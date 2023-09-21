CREATE TABLE "users" (
  "id" bigserial PRIMARY KEY 
);

CREATE TABLE "product"(
  "id" bigserial PRIMARY KEY
);

CREATE TABLE "promotion" (
  "id" bigserial PRIMARY KEY,
  "name" varchar,
  "description" text,
  "start_date" timestamptz,
  "end_date" timestamptz, 
  "total_user" bigserial
); 

CREATE TABLE "user_promotion_usage"(
  "id" bigserial PRIMARY KEY,
  "user_id" bigserial REFERENCES "users"("id"),
  "promotion_id" bigserial REFERENCES "promotion"("id"),
  "per_total_counts" bigserial 
);

CREATE TABLE "user_coupon_usage"(
  "id" bigserial PRIMARY KEY,
  "user_id" bigserial REFERENCES "users"("id"),
  "dis_id" bigserial,
  "use_count" int   
);

CREATE TABLE "user_coupon_usage2"(
  "id" bigserial PRIMARY KEY,
  "user_id" bigserial REFERENCES "users"("id"),
  "dis_id" bigserial,
  "use_at" timestamptz
)
CREATE TABLE "percentage_dis" (
  "id" bigserial PRIMARY KEY,
  "promotion_id" bigserial,
  "coupon_code" varchar(100),
  "percentage_off" varchar(10) NOT NULL,
  "start_date" timestamp NOT NULL,
  "end_date" timestamp NOT NULL,
  "max_uses" int NOT NULL
);

CREATE TABLE "fixed_amount_dis" (
  "id" bigserial PRIMARY KEY,
  "promotion_id" bigserial,
  "coupon_code" varchar(100),
  "fixed_amount_off" varchar(10) NOT NULL,
  "start_date" timestamp NOT NULL,
  "end_date" timestamp NOT NULL,
  "max_uses" int NOT NULL
);

CREATE TABLE "bogo_dis" (
  "id" bigserial PRIMARY KEY,
  "promotion_id" bigserial,
  "coupon_code" varchar(100),
  "buy_quantity" int NOT NULL,
  "free_quantity" int NOT NULL,
  "start_date" timestamp NOT NULL,
  "end_date" timestamp NOT NULL,
  "max_uses" int NOT NULL
);

CREATE TABLE "free_shipping_dis" (
  "id" bigserial PRIMARY KEY,
  "promotion_id" bigserial,
  "coupon_code" varchar(100),
  "start_date" timestamp NOT NULL,
  "end_date" timestamp NOT NULL,
  "max_uses" int NOT NULL
);

CREATE TABLE "bundled_dis" (
  "id" bigserial PRIMARY KEY,
  "promotion_id" bigserial,
  "coupon_code" varchar(100),
  "bundle_product_id" bigserial NOT NULL,
  "bundle_price" varchar(12) NOT NULL,
  "start_date" timestamp NOT NULL,
  "end_date" timestamp NOT NULL
);

CREATE TABLE "volume_dis" (
  "id" bigserial PRIMARY KEY,
  "promotion_id" bigserial,
  "coupon_code" varchar(100),
  "minimum_quantity" int NOT NULL,
  "dis_percentage" varchar(10) NOT NULL,
  "start_date" timestamp NOT NULL,
  "end_date" timestamp NOT NULL
);

CREATE TABLE "promotion_config" (
  "product_id" bigserial NOT NULL REFERENCES "product"("id"),
  "promotion_id" bigserial NOT NULL REFERENCES "promotion"("id"),
  "percentage_dis_id" bigserial REFERENCES "percentage_dis"("id"),
  "fixed_amount_dis_id" bigserial REFERENCES "fixed_amount_dis"("id"),
  "bogo_dis_id" bigserial REFERENCES "bogo_dis"("id"),
  "free_shipping_dis_id" bigserial REFERENCES "free_shipping_dis"("id"),
  "bundled_dis_id" bigserial REFERENCES "bundled_dis"("id"),
  "volume_dis_id" bigserial REFERENCES "volume_dis"("id")
);

