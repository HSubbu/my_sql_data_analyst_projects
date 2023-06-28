show tables;
desc sales;
/* Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?*/
select *
 from sales 
 where Amount >2000 and Boxes <200;
 /*How many shipments (sales) each of the sales persons had in the month of January 2022?*/
 select p.Salesperson,count(*) as sales_count 
 from sales s
 JOIN people p
 ON s.SPID = p.SPID
 where month(saleDate)=1 AND  year(saleDate) =2022
 group by 1
 ORDER BY 1
 select * from products limit 5;
 select * from sales limit 5;
 /*3. Which product sells more boxes? Milk Bars or Eclairs?*/
 select p.Product,SUM(s.Boxes) as total_boxes_sold
 from sales s
 JOIN products p
 ON s.PID = p.PID
 where p.Product in ('Milk Bars', 'Eclairs')
 GROUP BY 1
 ORDER BY 2 DESC
 
/*— 4. Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs? */
select p.Product,SUM(s.Boxes) as total_boxes_sold
 from sales s
 JOIN products p
 ON s.PID = p.PID
 where p.Product in ('Milk Bars', 'Eclairs')
       AND (s.Saledate Between '2022-2-1' AND '2022-2-7');
 GROUP BY 1
 ORDER BY 2 DESC
 
 /* 5. Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?*/
 select *,weekday(saleDate) as weekday 
 from sales
 where customers <100 and boxes <100 and weekday(saledate) =2
 
 /*— What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?*/
 select DISTINCT p.Salesperson
 from sales s
 join people p
 on s.SPID = p.SPID
 where s.saledate between '2022-1-1' and '2022-1-7'
 
 /* Which salespersons did not make any shipments in the first 7 days of January 2022? */
 select DISTINCT salesperson
 from people 
 where salesperson NOT IN 
 (select DISTINCT p.Salesperson
 from sales s
 join people p
 on s.SPID = p.SPID
 where s.saledate between '2022-1-1' and '2022-1-7') 
 
 /*How many times we shipped more than 1,000 boxes in each month? */
 select year(saledate),month(saledate),count(*) as ship_count
 from sales
 group by year(saledate),month(saledate)
 having count(*) >=1000
 
 /*Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months? */
 select year(s.saledate),month(saledate),count(*) as ship_count
 from sales s
 JOIN products p
 on p.PID = s.PID
 JOIN geo  g
 ON g.GeoID = s.GeoID
 WHERE g.Geo ='New Zealand' and p.product ='After Nines'
 group by 1,2
 order by 1,2
 
 /*India or Australia? Who buys more chocolate boxes on a monthly basis? */
 select year(s.saledate),month(saledate),g.geo,sum(s.boxes) as ship_count
 from sales s
 JOIN products p
 on p.PID = s.PID
 JOIN geo  g
 ON g.GeoID = s.GeoID
 WHERE g.Geo ='Australia' or g.Geo ='India'
 group by 1,2,3
 
 /* 
