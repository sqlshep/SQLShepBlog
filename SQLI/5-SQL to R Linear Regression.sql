--https://docs.microsoft.com/en-us/sql/advanced-analytics/tutorials/rtsql-create-a-predictive-model-r

--Test to see if R interface is working 
EXEC sp_execute_external_script  
  @language =N'R',    
  @script=N'OutputDataSet<-InputDataSet',      
  @input_data_1 =N'SELECT 1 AS hello'    
  WITH RESULT SETS (([hello] int not null));    
GO

--Find location of packages 
EXECUTE sp_execute_external_script  @language = N'R'
, @script = N'OutputDataSet <- data.frame(.libPaths());'
WITH RESULT SETS (([DefaultLibraryName] VARCHAR(MAX) NOT NULL));
GO

USE [TEST]
GO
DROP TABLE [dbo].[MTCars]
GO
USE [TEST]
GO
CREATE TABLE [dbo].[MTCars](
	[mpg] [float] NULL,
	[cyl] [float] NULL,
	[disp] [float] NULL,
	[hp] [float] NULL,
	[drat] [float] NULL,
	[wt] [float] NULL,
	[qsec] [float] NULL,
	[vs] [float] NULL,
	[am] [float] NULL,
	[gear] [float] NULL,
	[carb] [float] NULL,
	[make] [varchar](255) NULL,
)
GO


--https://docs.microsoft.com/en-us/sql/advanced-analytics/r/install-additional-r-packages-on-sql-server
--if the MTCARS dataset will be there as it ships with 
-- But if a package has not been installed on server you will need to do this
--find the rgui.exe that shipped with sql and run "install.packages('xxx')"
--Probably here  "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\R_SERVICES\bin"
--then, this should work "package::dataset" name format


INSERT INTO MTcars
EXEC sp_execute_external_script
        @language = N'R'
        , @script = N'Mtcars_1  <- mtcars
					Mtcars_1$car <- rownames(mtcars)
					rownames(Mtcars_1) <- NULL;'
        , @input_data_1 = N''
        , @output_data_1_name = N'Mtcars_1'

go

--just to see if it is really there
select * from MTCars

--create the procedure that will create a model 
DROP PROCEDURE IF EXISTS generate_lm_MTCar;
GO
--create a proc to create the linear model 
Create PROCEDURE generate_lm_MTCar
AS
BEGIN
    EXEC sp_execute_external_script
    @language = N'R'
    , @script = N'lrmodel <- rxLinMod(formula = mpg ~ disp + hp, data = MTCars);
        MTCars_model <- data.frame(payload = as.raw(serialize(lrmodel, connection=NULL)));'
    , @input_data_1 = N'SELECT mpg, disp, hp FROM MTCars'
    , @input_data_1_name = N'MTCars'
    , @output_data_1_name = N'MTCars_model'
    WITH RESULT SETS ((model varbinary(max)));
End;

--Create a table for the model to be stored 
drop table MTCars_models
go
--crete a table to store the linear model 
CREATE TABLE MTCars_models (
    model_name varchar(30) not null default('default model') primary key,
    model varbinary(max) not null);

GO

--run the model and have the results (the actual model) stored in a table 
INSERT INTO MTCars_models (model)
EXEC generate_lm_MTCar;
go

select * from MTCars_models

--to try this out we will eed a new dataset to test 
DROP TABLE [dbo].[NewDataMTCars]
GO
CREATE TABLE [dbo].[NewDataMTCars](
	[mpg] [int] NOT NULL,
	[disp] [int] NOT NULL,
	[hp] [int] NOT NULL
) 
GO
insert [NewDataMTCars] (mpg,disp,hp)
values (0,160,105), (0,225,105), (0,167,123)
go
select * from [NewDataMTCars]
go

--Now lets predict something using the mode we created and the new dataset 
--this will not be stored anywhere, just output to the console. 
DECLARE @carmodel varbinary(max) = (SELECT model FROM [dbo].MTCars_models WHERE model_name = 'default model');
EXEC sp_execute_external_script 
    @language = N'R'
    , @script = N'
            current_model <- unserialize(as.raw(carmodel));
            new <- data.frame(NewData);
            predicted.carmodel <- rxPredict(current_model, new);
            str(predicted.carmodel);
            OutputDataSet <- cbind(new, ceiling(predicted.carmodel));
            '
    , @input_data_1 = N' SELECT disp,hp FROM [dbo].[NewDataMTCars] '
    , @input_data_1_name = N'NewData'
    , @params = N' @carmodel varbinary(max)'
    , @carmodel = @carmodel
WITH RESULT SETS ((disp INT, hp INT, mpg INT ))
