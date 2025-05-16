use mini_shop;

# todo: 1. 평균 가격보다 비싼 모든 제품을 조회하세요.
select *
from products p
where p.price > (select avg(p2.price)
                 from products p2
);
# todo: 2. 가장 최근에 주문한 고객의 정보를 조회하세요.
select *
from customers c
where c.customer_id in (
    select customer_id
    from orders o
    where order_date = (
        select max(order_date)
        from orders o
    )
);
# todo: 3. 음료 카테고리(category_name = '음료')에 속하는 모든 제품을 조회하세요.
select *
from products p
where p.category_id = (
    select c.category_id
    from categories c
    where c.category_name = '음료'
);
# todo: 4. 서울에 위치한 고객이 주문한 모든 주문을 조회하세요.
select *
from orders o
where o.customer_id in (
    select c.customer_id
    from customers c
    where c.city = '서울'
);
# todo: 5. 어떤 직원보다도 더 많은 주문을 처리한 직원을 조회하세요.
# employee_id 당 처리한 주문의 수
select o.employee_id, count(order_id) as count
from orders o
group by o.employee_id
order by count desc limit 1;
# 최대 한개만 반환 값에서
select employee_id
from (
         select o.employee_id, count(order_id) as count
         from orders o
         group by o.employee_id
         order by count desc limit 1
     ) as test;
select *
from employees
where employee_id = (
    select employee_id
    from (
             select o.employee_id, count(order_id) as count
             from orders o
             group by o.employee_id
             order by count desc limit 1
         ) as test
);
# todo: 6. 적어도 한 번 이상 주문한 적이 있는 고객을 조회하세요.
# 주문을 조회
select *
from orders;
# 각 고객별 주문 량을 조회
select o.customer_id, count(o.order_id)
from orders o
group by o.customer_id ;
# 위 결과에서 customer_id 만 반환하도록 쿼리
select search.customer_id
from (select o.customer_id, count(o.order_id)
      from orders o
      group by o.customer_id) as search;
# 위 결과를 포함하는 고객의 정보를 조회
select *
from customers c
where customer_id in (
    select search.customer_id
    from (select o.customer_id, count(o.order_id)
          from orders o
          group by o.customer_id) as search
);
# todo: 7. 각 카테고리별 평균 가격을 구한 후, 그 평균 가격보다 비싼 제품을 해당 카테고리에서 조회하세요.
# todo: do it
# 각 카테고리 별 평균 가격 구하기 카테고리 번호 순으로 정렬
select p.category_id, avg(p.price)
from products p
group by p.category_id
order by p.category_id;
# 위 쿼리에서 평균 값만 반환
select `price average`.avg
from (
         select p.category_id, avg(p.price) as avg
         from products p
         group by p.category_id
         order by p.category_id
     ) as `price average`;


# todo: 8. 각 고객별 총 주문 금액을 계산한 후, 평균 주문 금액보다 많이 소비한 고객을 조회하세요.
# 각 고객 별 총 주문 금액을 계산 해야 함
# 각 고객 별 order id
select o.customer_id, o.order_id
from orders o;
# 위 쿼리와 order_details 테이블과 합체
select *
from order_details od
         join (select o.customer_id, o.order_id
               from orders o) as order_number_by_customer on od.order_id = order_number_by_customer.order_id;
# 위 쿼리에서 필요한 데이터반 가져오도록 (주문 상세 id, 주문 id, 제품 id, 고객 id, 주문 수량)
select od.order_detail_id,od.order_id, od.product_id, order_number_by_customer.customer_id, od.quantity
from order_details od
         join (
    select o.customer_id, o.order_id
    from orders o
) as order_number_by_customer
              on od.order_id = order_number_by_customer.order_id;
# 위 쿼리에서 주문 상세 별 총 합 추가 : 1쿼리
select od.order_detail_id,od.order_id, od.product_id, order_number_by_customer.customer_id, od.quantity, p.price, (od.quantity * p.price) as total
from order_details od
         join (
    select o.customer_id, o.order_id
    from orders o
) as order_number_by_customer
              on od.order_id = order_number_by_customer.order_id
         join products p on od.product_id = p.product_id;
# 위 쿼리에서 주문 평균 계산 : 2쿼리
select avg(info.total)
from (
         select od.order_detail_id,od.order_id, od.product_id, order_number_by_customer.customer_id, od.quantity, p.price, (od.quantity * p.price) as total
         from order_details od
                  join (
             select o.customer_id, o.order_id
             from orders o
         ) as order_number_by_customer
                       on od.order_id = order_number_by_customer.order_id
                  join products p on od.product_id = p.product_id
     ) as info;
# 1쿼리에서 각 고객별 금액 총합 쿼리
select info.customer_id, sum(info.total)
from (
         select od.order_detail_id,od.order_id, od.product_id, order_number_by_customer.customer_id, od.quantity, p.price, (od.quantity * p.price) as total
         from order_details od
                  join (
             select o.customer_id, o.order_id
             from orders o
         ) as order_number_by_customer
                       on od.order_id = order_number_by_customer.order_id
                  join products p on od.product_id = p.product_id
     ) as info
GROUP BY info.customer_id ;
# 위 쿼리에서 2쿼리의 평균 보다 큰 customer_id 를 출력
select info.customer_id, avg(info.total) as total_avg
from (
         select od.order_detail_id,od.order_id, od.product_id, order_number_by_customer.customer_id, od.quantity, p.price, (od.quantity * p.price) as total
         from order_details od
                  join (
             select o.customer_id, o.order_id
             from orders o
         ) as order_number_by_customer
                       on od.order_id = order_number_by_customer.order_id
                  join products p on od.product_id = p.product_id
     ) as info
GROUP BY info.customer_id
having total_avg > (
    select avg(info.total)
    from (
             select od.order_detail_id,od.order_id, od.product_id, order_number_by_customer.customer_id, od.quantity, p.price, (od.quantity * p.price) as total
             from order_details od
                      join (
                 select o.customer_id, o.order_id
                 from orders o
             ) as order_number_by_customer
                           on od.order_id = order_number_by_customer.order_id
                      join products p on od.product_id = p.product_id
         ) as info
);
# todo: 9. 각 카테고리의 이름과 해당 카테고리에 속한 제품 수를 조회하세요.
# 각 카테고리 별 제품의 수 조회
select p.category_id, count(p.product_id)
from products p
group by p.category_id;
# 카테고리 id 별 이름 조회
select c.category_id, c.category_name
from categories c;
# 각 카테고리 별 제품 수 조회
select c.category_id, c.category_name, count.product_count
from categories c
         join (select p.category_id, count(p.product_id) as product_count
               from products p
               group by p.category_id) as count on count.category_id = c.category_id;

# todo: 10. 각 고객별로 가장 최근 주문한 날짜를 함께 조회하세요.
# 각 고객 별 최근 주문 날짜
select o.customer_id, max(o.order_date)
from orders o
GROUP BY o.customer_id ;
# 각 고객의 정보와 고객 별 최근 주문 날짜 출력
select c.customer_id, customer_name, contact_name, address, city, postal_code, country, most_recent_order_date.order_date
from customers c
         join (
    select o.customer_id, max(o.order_date) as order_date
    from orders o
    GROUP BY o.customer_id
) as most_recent_order_date on c.customer_id = most_recent_order_date.customer_id;
# todo: 11. 각 카테고리에서 가장 비싼 제품을 조회하세요.
# 카테고리 별 가장 비싼 제품 조회
select p.category_id, max(p.price)
from products p
GROUP BY p.category_id;
select *
from products p
         join (select p.category_id, max(p.price) as max_price
               from products p
               GROUP BY p.category_id) as expensive_products_by_category on p.category_id = expensive_products_by_category.category_id
where p.price = expensive_products_by_category.max_price;
# todo: 12. 각 고객별로 평균보다 높은 금액의 주문만 조회하세요.
# 8번 문제의 답을 이용
select info.order_id, avg(info.total) as total_avg
from (
         select od.order_detail_id,od.order_id, od.product_id, order_number_by_customer.customer_id, od.quantity, p.price, (od.quantity * p.price) as total
         from order_details od
                  join (
             select o.customer_id, o.order_id
             from orders o
         ) as order_number_by_customer
                       on od.order_id = order_number_by_customer.order_id
                  join products p on od.product_id = p.product_id
     ) as info
GROUP BY info.order_id
having total_avg > (
    select avg(info.total)
    from (
             select od.order_detail_id,od.order_id, od.product_id, order_number_by_customer.customer_id, od.quantity, p.price, (od.quantity * p.price) as total
             from order_details od
                      join (
                 select o.customer_id, o.order_id
                 from orders o
             ) as order_number_by_customer
                           on od.order_id = order_number_by_customer.order_id
                      join products p on od.product_id = p.product_id
         ) as info
);
# 위 쿼리에서 주문의 id 만 추출
select order_id_with_total_avg.order_id
from (
         select info.order_id, avg(info.total) as total_avg
         from (
                  select od.order_detail_id,od.order_id, od.product_id, order_number_by_customer.customer_id, od.quantity, p.price, (od.quantity * p.price) as total
                  from order_details od
                           join (
                      select o.customer_id, o.order_id
                      from orders o
                  ) as order_number_by_customer
                                on od.order_id = order_number_by_customer.order_id
                           join products p on od.product_id = p.product_id
              ) as info
         GROUP BY info.order_id
         having total_avg > (
             select avg(info.total)
             from (
                      select od.order_detail_id,od.order_id, od.product_id, order_number_by_customer.customer_id, od.quantity, p.price, (od.quantity * p.price) as total
                      from order_details od
                               join (
                          select o.customer_id, o.order_id
                          from orders o
                      ) as order_number_by_customer
                                    on od.order_id = order_number_by_customer.order_id
                               join products p on od.product_id = p.product_id
                  ) as info
         )
     ) as order_id_with_total_avg;
# 위 쿼리에서 주문의 정보만 출력
select *
from orders o
where o.order_id in (
    select order_id_with_total_avg.order_id
    from (
             select info.order_id, avg(info.total) as total_avg
             from (
                      select od.order_detail_id,od.order_id, od.product_id, order_number_by_customer.customer_id, od.quantity, p.price, (od.quantity * p.price) as total
                      from order_details od
                               join (
                          select o.customer_id, o.order_id
                          from orders o
                      ) as order_number_by_customer
                                    on od.order_id = order_number_by_customer.order_id
                               join products p on od.product_id = p.product_id
                  ) as info
             GROUP BY info.order_id
             having total_avg > (
                 select avg(info.total)
                 from (
                          select od.order_detail_id,od.order_id, od.product_id, order_number_by_customer.customer_id, od.quantity, p.price, (od.quantity * p.price) as total
                          from order_details od
                                   join (
                              select o.customer_id, o.order_id
                              from orders o
                          ) as order_number_by_customer
                                        on od.order_id = order_number_by_customer.order_id
                                   join products p on od.product_id = p.product_id
                      ) as info
             )
         ) as order_id_with_total_avg
);
# todo: 13. 적어도 하나 이상의 주문을 받은 직원을 조회하세요.
# 직원당 주문을 처리한 횟수
select o.employee_id, count(o.order_id) as count
from orders o
group by o.employee_id
order by count asc;
# 직원의 id 만 쿼리
select id.employee_id
from (
         select o.employee_id, count(o.order_id) as count
         from orders o
         group by o.employee_id
         order by count asc
     ) as id;
# 이 직원 id 값에 포함되지 않은 직원 조회
select *
from employees e
where e.employee_id not in (
    select id.employee_id
    from (
             select o.employee_id, count(o.order_id) as count
             from orders o
             group by o.employee_id
         ) as id
);
# todo: 14. 한 번도 주문하지 않은 고객을 조회하세요.
# 한번도 주문 하지 않은 고객이 없으므로 새로 하나 만들기
INSERT INTO `customers` (`customer_id`, `customer_name`, `contact_name`, `address`, `city`, `postal_code`, `country`) VALUES
    (21, '없는마트', '호지영', '없는로 666', '찾지 못한 도시', '666666', '대한민국');
# 한번 이상 주문한 고객을 조회
select o.customer_id, count(o.order_id)
from orders o
group by o.customer_id;
# 사용자의 id 만 반환하도록 쿼리
select search.customer_id
from (select o.customer_id, count(o.order_id)
      from orders o
      group by o.customer_id) as search;
# 위 결과에 포함 되지 않은 사용자 조회
select *
from customers
where customer_id not in (
    select search.customer_id
    from (select o.customer_id, count(o.order_id)
          from orders o
          group by o.customer_id) as search
);

# 아래는 귀찮아용
# todo: 15. 모든 음료 카테고리 제품보다 비싼 제품을 조회하세요.

# todo: 16. 적어도 한 개 이상의 유제품 카테고리 제품보다 비싼 제품을 조회하세요.

# todo: 17. 각 카테고리별 평균 가격을 구한 후, 그 평균 가격보다 비싼 제품을 조회하세요.

# todo: 18. 각 고객별 총 주문 금액을 계산한 후, 상위 5명의 고객을 조회하세요.

# todo: 19. 각 카테고리별 제품 수와 각 공급업체별 제품 수를 구한 후, 이를 결합하여 카테고리와 공급업체별 제품 분포를 분석하세요.
