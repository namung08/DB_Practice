use mini_shop;
# todo: 전체 제품(products) 수를 계산하세요.
select count(p.product_id) as '전체 제픔의 수'
from products p;
# todo: 모든 제품의 평균 가격(Price)을 계산하세요.
select avg(p.price) as '모든 제품의 평균 가격'
from products p;
# todo: 가장 비싼 제품과 가장 저렴한 제품의 가격을 조회하세요.
select max(p.price) as '가장 비싼 제품', min(p.price) as '가장 저렴한 제품'
from products p;
# todo: 모든 주문 상세(order_details)에서 주문된 총 제품 수량(Quantity)을 계산하세요.
select sum(od.quantity) as '주문된 총 제품 수량'
from order_details od;
