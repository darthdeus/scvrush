insert into posts (title, content, created_at) select post_title, post_content, post_date from wp_posts  where post_status = "publish";
select * from posts;


delete from posts;


insert into posts (title, content, created_at, featured_image)
	select p2.post_title, p2.post_content, p2.post_date, m.meta_value
	from wp_posts p
	left join wp_postmeta m on p.ID = m.post_id
	left join wp_posts p2 on p2.ID = p.post_parent
	where p2.post_status = "publish"
	and m.meta_key = "_wp_attached_file"
	group by p2.post_title
	order by p2.post_date desc
;
	;
	select p2.post_title, p2.post_content, p2.post_date, m.meta_value
	from wp_posts p
	left join wp_postmeta m on p.ID = m.post_id
	left join wp_posts p2 on p2.ID = p.post_parent
	where p2.post_status = "publish"
	and m.meta_key = "_wp_attached_file"
	group by p2.post_title
	order by p2.post_date desc
;

select post_title, post_parent from wp_posts;
select * from wp_postmeta where meta_key = "_wp_attached_file";


select * from wp_posts where post_status = "publish";

select * from wp_term_taxonomy ta
left join wp_terms te
on ta.term_id = te.term_id
where taxonomy = "category"  ;

select * from wp_posts where post_status = "publish";



insert into users (username, email) select user_login, user_email from wp_users;
select user_login, user_email from wp_users;
select * from users;
