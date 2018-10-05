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
