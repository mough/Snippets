DECLARE @data XML = '<root>
<row
CategoryName="Children" ImagePath="children.jpg"
Color="blue" RecommendedTimeLineMonths="6" />
<row CategoryName="Debt"
ImagePath="debt.jpg" Color="teal"
AppType="revolving" RecommendedTimeLineMonths="3" />
</root>'
 
 
INSERT INTO MyTable ( CategoryName,
ImagePath, Color, AppType, RecommendedTimeLineMonths, DisplayOrder )
SELECT XMLD.CategoryName, XMLD.ImagePath, XMLD.Color, XMLD.AppType, XMLD.RecommendedTimeLineMonths, XMLD.DisplayOrder
FROM   ( 
SELECT T.r.value('@CategoryName', 'varchar(1024)')
CategoryName, T.r.value('@ImagePath', 'varchar(1024)')
ImagePath,T.r.value('@Color', 'varchar(1024)') Color, T.r.value('@AppType', 'varchar(1024)') AppType,
T.r.value('@RecommendedTimeLineMonths', 'int') RecommendedTimeLineMonths,
T.r.value('@DisplayOrder', 'int') DisplayOrder
FROM   @data.nodes('//row ')T(r)) XMLD
WHERE  NOT
EXISTS (   SELECT 1 FROM OtherTable tb WHERE  tb.CategoryName= XMLD.CategoryName )



BEGIN TRY                                 
    BEGIN TRAN WhateverNameYouWant
    -- DELETE or other stuff here                           
    COMMIT TRAN WhateverNameYouWant -- IF YOU GET HERE THEN ALL WENT WELL                   
END TRY                                  
 
BEGIN CATCH                                     
    DECLARE @errMsg VARCHAR(MAX);
    SELECT @errMsg='SQLException:' + ISNULL(CONVERT(VARCHAR, ERROR_NUMBER()), '') + ' Severity:'
                   + ISNULL(CONVERT(VARCHAR, ERROR_SEVERITY()), '') + ' State:'
                   + ISNULL(CONVERT(VARCHAR, ERROR_STATE()), '') + ' Procedure:' + ISNULL(ERROR_PROCEDURE(), '')
                   + ' Line:' + ISNULL(CONVERT(VARCHAR, ERROR_LINE()), '') + ' Message:'
                   + ISNULL(ERROR_MESSAGE(), '');
    BEGIN TRY
        IF XACT_STATE() != 0
           ROLLBACK TRAN  ;
    END TRY
    BEGIN CATCH
    END CATCH   
    RAISERROR(@errMsg, 11, 1)                             
    -- To send an alert           
    -- EXEC dbo.add_simpleAlert @errMsg, 'Meaningful name here', 0 ; 
END CATCH
