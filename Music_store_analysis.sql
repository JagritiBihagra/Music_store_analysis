   select * from employee$  

   -- Q1: Who is the senior most employee based on job title?
   select  top 1 * from employee$ order by levels desc

   --Q2: which country have the most invoices? 
   select count(*)total_invoices , billing_country from invoice$ group by billing_country
   order by total_invoices desc

   --Q3: what are top 3 values of total invoices?
   select top 3 total from invoice$ group by total
   order by total desc

   --Q4: Which city has the best customer. Write a query that returns one city
   -- that has one city that has the highes sum of invoice totals . return both the city name and sum of all invoice totals
   select sum(total) invoice_total , billing_city from invoice$
   group by billing_city order by invoice_total desc
    
   --Q5: who is the best customer? Who has the most money will be declared as the best customer. write
   -- a query that returns the person who has spent the most money.
   select top 1 customer$.customer_id, customer$.first_name, customer$.last_name, sum(invoice$.total) as total from customer$ 
   inner join invoice$ on customer$.customer_id= invoice$.customer_id
   group by customer$.first_name
   order by total desc

   select top 1 a.customer_id, a.first_name, a.last_name,sum(b.total) total from 
   customer$ a inner join invoice$ b on a.customer_id=b.customer_id
   group by a.customer_id order by total desc 

   --Q6:Write query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A 
  
   select * from genre$
   select distinct c.email,c.first_name, c.last_name from customer$ c 
   join invoice$ d on c.customer_id= d.customer_id
   join invoice_line$ e on d.invoice_id=e.invoice_id 
   where track_id in (select a.track_id from track$ a join genre$ b on a.track_id=b.genre_id
   where b.name like 'Rock%')
   order by email

   --Q7:  Write a query that returns the Artist name and total track count of the top 10 rock bands

   select artist$.artist_id, artist$.name ,count(artist$.artist_id) number_of_song 
   from track$
   join album$ on album$.album_id=track$.album_id
   join artist$ on artist$.artist_id=album$.artist_id 
   join genre$ on genre$.genre_id=track$.track_id
   where genre$.name = 'Rock' 
   group by artist$.artist_id, artist$.name
   order by number_of_song desc 

   --Q8:  Return all the track names that have a song length longer than the average song length. 
   --     Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed First
   select name,milliseconds from  track$ where milliseconds>
   (select avg(milliseconds) from track$)
   order by milliseconds desc

   --Q9: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent.

   with best_selling_artist as(
   select artist$.artist_id as artist_id , artist$.name as artist_name,
   sum(invoice_line$.unit_price*invoice_line$.quantity) as total_sales
   from invoice_line$
   join album$ on album$.album_id= track$.album_id
   join artist$ on artist$.artist_id=album$.artist_id 
   join track$ on track$.track_id= invoice_line$.track_id
   group by 1
   order by 3 desc )
 select customer$.customer_id, customer$.first_name,customer$.last_name,
 bsa.artist_name, SUM(invoice_line$.unit_price*invoice_line$.quantity)
 as amount_spent from invoice$
 join customer$ on customer$.customer_id=invoice$.customer_id
 join invoice_line$ on invoice_line$.invoice_id=invoice$.invoice_id
 join track$ on track$.track_id= invoice_line$.track_id
 join best_selling_artist as bsa on bsa.artist_id= album$.artist_id
 group by 1,2,3,4
 order by 5 desc

 --Q10: We want to find out the most popular music Genre for each country We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared return all Genres.

 with popular_genre as(
 select count(invoice_line$.quantity) as purchases, customer$.country, genre$.name,
 genre$.genre_id,rank() over(partition by customer$.country order by count(invoice_line$.quantity) desc) rnk from
 invoice_line$
 join invoice$ on invoice_line$.invoice_id= invoice$invoice_id
 join track$ on invoice_line$.track_id=track$.track_id
 join genre$ on genre$.genre_id=track$.genre_id
 join customer$ on customer$.customer_id=invoice$.customer_id
 group by 2,3,4
 order by 2 asc , 1 desc) 
 select * from popular_genre where rnk <=1

  with popular_genre as(
 select count(invoice_line$.quantity) as purchases, customer$.country, genre$.name,
 genre$.genre_id,rank() over(partition by customer$.country order by count(invoice_line$.quantity) desc) rnk from
 invoice_line$
 join invoice$ on invoice_line$.invoice_id= invoice$invoice_id
 join track$ on invoice_line$.track_id=track$.track_id
 join genre$ on genre$.genre_id=track$.genre_id
 join customer$ on customer$.customer_id=invoice$.customer_id
 group by 2,3,4
 order by 2 asc , 1 desc) 
 select * from popular_genre where rnk <=1