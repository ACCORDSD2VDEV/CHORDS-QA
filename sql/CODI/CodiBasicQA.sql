--Set to either CODI or DBO
DECLARE @codiSchema VARCHAR(10) = 'CODI';

DROP TABLE IF EXISTS #CODITABLES;
	WITH cte_coditables
	AS (
		SELECT 1 AS ID
			,'PROGRAM' AS TableName
		
		UNION
		
		SELECT 2 AS ID
			,'SESSION' AS TableName
		
		UNION
		
		SELECT 3 AS ID
			,'IDENTITY' AS TableName
		)
	SELECT *
	INTO #CODITABLES
	FROM cte_coditables;

DROP TABLE IF EXISTS #ChordsCodiTableResults;
CREATE TABLE #ChordsCodiTableResults (
	TableName VARCHAR(MAX) DEFAULT NULL
	,TableFound VARCHAR(MAX) DEFAULT NULL
	,RowsFound VARCHAR(max) DEFAULT NULL
	);

DECLARE @counter INT = 1;
DECLARE @count INT = (
		SELECT COUNT(*)
		FROM #CODITABLES
		);
DECLARE @TargetTable AS NVARCHAR(20);
DECLARE @SQL1 NVARCHAR(max);
DECLARE @SQL2 NVARCHAR(max);
DECLARE @MessageRef1 AS NVARCHAR(max) = NULL;
DECLARE @MessageRef2 AS NVARCHAR(max) = NULL;
DECLARE @counts INT = 0;
DECLARE @exist AS NVARCHAR(max)
DECLARE @exists NVARCHAR(max)

WHILE @counter <= @count
BEGIN
	SELECT @TargetTable = TableName
	FROM #CODITABLES
	WHERE ID = @counter;

	SET @SQL1 = 'SELECT TOP 1 @exists = ''Y''
		FROM ' + @codiSchema + '.' + @TargetTable;
	SET @SQL2 = 'SELECT @cnt = count(*)
		FROM ' + @codiSchema + '.' + @TargetTable;

	BEGIN TRY
		PRINT @SQL1

		EXEC sp_executesql @SQL1
			,N'@exists varchar(max) OUTPUT'
			,@exists = @exist OUTPUT;

		SET @MessageRef1 = @exist;
	END TRY

	BEGIN CATCH
		SELECT @MessageRef1 = 'Error Finding Table';
	END CATCH

	BEGIN TRY
		EXEC sp_executesql @SQL2
			,N'@cnt int OUTPUT'
			,@cnt = @counts OUTPUT;

		SET @MessageRef2 = @counts;
	END TRY

	BEGIN CATCH
		SELECT @MessageRef2 = 'Error counting rows';
	END CATCH

	INSERT INTO #ChordsCodiTableResults
	VALUES (
		@TargetTable
		,@MessageRef1
		,@MessageRef2
		);

	SET @counter = @counter + 1;
	SET @MessageRef1 = NULL;
	SET @MessageRef2 = NULL;
	SET @exist = NULL;
	SET @counts = 0;
END;

SELECT *
FROM #ChordsCodiTableResults;
