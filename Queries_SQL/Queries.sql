-- Query nº1: Join of titles and actors:
create temporary table titles_actors
select f.title, complete_name
from film as f
left join actor_has_film as ahf
on f.film_id=ahf.film_id
group by f.title, complete_name
order by count(complete_name) desc;

select * from titles_actors;


-- Query nº2 : The most workable actors - aka Mario Casas in 2015:

create temporary table most_workable_actors
select a.complete_name, count(title)
from actor as a
left join actor_has_film as ahf
on a.actor_id=ahf.actor_id
group by a.complete_name
order by count(title) desc
limit 10;

select * from most_workable_actors;


-- Query nº3 : The films with more actors - aka "Valentine's Day" (half Hollywood as cast):

create temporary table films_with_more_actors
select f.title, count(complete_name)
from film as f
left join actor_has_film as ahf
on f.film_id=ahf.film_id
group by f.title
order by count(complete_name) desc
limit 10;

select * from films_with_more_actors;


-- Query nº4 : Actors that act in the films with more actors:

create temporary table actors_in_films_with_more_actors2
select f.title, count(complete_name), group_concat(complete_name) as gccn
from film as f
left join actor_has_film as ahf
on f.film_id=ahf.film_id
group by f.title
order by count(complete_name) desc
limit 10;

select * from actors_in_films_with_more_actors2;


-- Query nº5 : The most popular categories:

select name, count(title)
from category as c
left join actor_has_film as ahf
on c.category_id=ahf.category_id
group by name
order by count(title) desc
limit 5;


-- Query nº6 : Most popular actors by categories

select acn, ct, group_concat(c.name)
from (select a.complete_name as acn, count(title) as ct, a.actor_id, category_id
		from actor as a
		left join actor_has_film as ahf
		on a.actor_id=ahf.actor_id
		group by a.complete_name
		order by count(title) desc
		limit 10) as aahf
left join category as c
on aahf.category_id=c.category_id
group by acn
order by ct desc
limit 10;

