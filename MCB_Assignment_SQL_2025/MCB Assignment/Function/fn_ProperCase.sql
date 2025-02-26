USE [MCB_Assignment_2025]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ProperCase]    Script Date: 23/02/2025 22:45:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_ProperCase] (@str NVARCHAR(4000))
RETURNS NVARCHAR(4000)
AS
BEGIN
    --------------------------------------------------------------------------------------------
    -- Function: fn_ProperCase
    --
    -- Purpose:
    --   Converts the input string to proper case.
    --
    -- Process:
    --   1. Converts the entire string to lowercase.
    --   2. Capitalizes the first character.
    --   3. Iterates through the string and capitalizes any character that follows a space.
    --------------------------------------------------------------------------------------------
    DECLARE @result NVARCHAR(4000);
    
    --------------------------------------------------------------------------------------------
    -- Step 1: Convert the entire string to lowercase.
    --------------------------------------------------------------------------------------------
    SET @result = LOWER(@str);

    --------------------------------------------------------------------------------------------
    -- Step 2: Capitalize the first character of the string.
    --------------------------------------------------------------------------------------------
    SET @result = STUFF(@result, 1, 1, UPPER(SUBSTRING(@result, 1, 1)));

    --------------------------------------------------------------------------------------------
    -- Step 3: Loop through the string starting from the second character.
    --          For each character that follows a space, capitalize it.
    --------------------------------------------------------------------------------------------
    DECLARE @i INT = 2;
    WHILE @i <= LEN(@result)
    BEGIN
         IF SUBSTRING(@result, @i - 1, 1) = ' '
         BEGIN
              SET @result = STUFF(@result, @i, 1, UPPER(SUBSTRING(@result, @i, 1)));
         END
         SET @i = @i + 1;
    END

    --------------------------------------------------------------------------------------------
    -- Return the properly formatted string.
    --------------------------------------------------------------------------------------------
    RETURN @result;
END;
