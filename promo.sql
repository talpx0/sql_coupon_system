CREATE TABLE "promotion" (
  "id" bigserial PRIMARY KEY,
  "name" varchar,
  "description" text,
  "start_date" timestamptz,
  "end_date" timestamptz, 
  "total_user" bigint
); 

CREATE TABLE "user_promotion_usage"(
  "id" bigserial PRIMARY KEY,
  "user_id" bigint REFERENCES "users"("id"),
  "promotion_id" bigint REFERENCES "promotion"("id"),
  "per_total_counts" bigint 
);

CREATE TABLE "user_coupon_usage"(
  "id" bigserial PRIMARY KEY,
  "user_id" bigint REFERENCES "users"("id"),
  "dis_id" bigint,
  "use_count" int   
);

CREATE TABLE "user_coupon_usage2"(
  "id" bigserial PRIMARY KEY,
  "user_id" bigint REFERENCES "users"("id"),
  "dis_id" bigint,
  "use_at" timestamptz
)
CREATE TABLE "percentage_dis" (
  "id" bigserial PRIMARY KEY,
  "coupon_code" varchar(100),
  "promotion_id" bigint REFERENCES "promotion"("id"),
  "percentage_off" varchar(10) NOT NULL,
  "start_date" timestamp NOT NULL,
  "end_date" timestamp NOT NULL,
  "max_uses" int NOT NULL
);

CREATE TABLE "fixed_amount_dis" (
  "id" bigserial PRIMARY KEY,
  "coupon_code" varchar(100),
  "promotion_id" bigint REFERENCES "promotion"("id"),
  "fixed_amount_off" varchar(10) NOT NULL,
  "start_date" timestamp NOT NULL,
  "end_date" timestamp NOT NULL,
  "max_uses" int NOT NULL
);

CREATE TABLE "bogo_dis" (
  "id" bigserial PRIMARY KEY,
  "promotion_id" bigint REFERENCES "promotion"("id"),
  "coupon_code" varchar(100),
  "buy_quantity" int NOT NULL,
  "free_quantity" int NOT NULL,
  "start_date" timestamp NOT NULL,
  "end_date" timestamp NOT NULL,
  "max_uses" int NOT NULL
);

CREATE TABLE "free_shipping_dis" (
  "id" bigserial PRIMARY KEY,
  "promotion_id" bigint REFERENCES "promotion"("id"),
  "coupon_code" varchar(100),
  "start_date" timestamp NOT NULL,
  "end_date" timestamp NOT NULL,
  "max_uses" int NOT NULL
);

CREATE TABLE "bundled_dis" (
  "id" bigserial PRIMARY KEY,
  "promotion_id" bigint REFERENCES "promotion"("id"),
  "coupon_code" varchar(100),
  "bundle_product_id" bigint NOT NULL,
  "bundle_price" varchar(12) NOT NULL,
  "start_date" timestamp NOT NULL,
  "end_date" timestamp NOT NULL
);

CREATE TABLE "volume_dis" (
  "id" bigserial PRIMARY KEY,
  "promotion_id" bigint REFERENCES "promotion"("id"),
  "coupon_code" varchar(100),
  "minimum_quantity" int NOT NULL,
  "dis_percentage" varchar(10) NOT NULL,
  "start_date" timestamp NOT NULL,
  "end_date" timestamp NOT NULL
);

CREATE TABLE "promotion_config" (
  "product_id" bigint UNIQUE NOT NULL,
  "promotion_id" bigint NOT NULL REFERENCES "promotion"("id"),
  "percentage_dis_id" bigint REFERENCES "percentage_dis"("id"),
  "fixed_amount_dis_id" bigint REFERENCES "fixed_amount_dis"("id"),
  "bogo_dis_id" bigint REFERENCES "bogo_dis"("id"),
  "free_shipping_dis_id" bigint REFERENCES "free_shipping_dis"("id"),
  "bundled_dis_id" bigint REFERENCES "bundled_dis"("id"),
  "volume_dis_id" bigint REFERENCES "volume_dis"("id")
);



CREATE INDEX ON "promotion" ("name");

CREATE INDEX ON "promotion" ("start_date");

CREATE INDEX ON "promotion" ("end_date");

CREATE INDEX ON "percentage_dis" ("percentage_off");

CREATE INDEX ON "percentage_dis" ("promotion_id");

CREATE INDEX ON "fixed_amount_dis" ("promotion_id");

CREATE INDEX ON "bogo_dis" ("promotion_id");

CREATE INDEX ON "free_shipping_dis" ("promotion_id");

CREATE INDEX ON "bundled_dis" ("bundle_product_id");

CREATE INDEX ON "volume_dis" ("promotion_id");

CREATE INDEX ON "promotion_config" ("product_id");

CREATE INDEX ON "promotion_config" ("promotion_id");

CREATE INDEX ON "promotion_config" ("percentage_dis_id");

CREATE INDEX ON "promotion_config" ("fixed_amount_dis_id");

CREATE INDEX ON "promotion_config" ("bogo_dis_id");

CREATE INDEX ON "promotion_config" ("free_shipping_dis_id");

CREATE INDEX ON "promotion_config" ("bundled_dis_id");

CREATE INDEX ON "promotion_config" ("volume_dis_id");


ALTER TABLE "percentage_dis" ADD FOREIGN KEY ("promotion_id") REFERENCES "promotion" ("id");

ALTER TABLE "fixed_amount_dis" ADD FOREIGN KEY ("promotion_id") REFERENCES "promotion" ("id");

ALTER TABLE "bogo_dis" ADD FOREIGN KEY ("promotion_id") REFERENCES "promotion" ("id");

ALTER TABLE "free_shipping_dis" ADD FOREIGN KEY ("promotion_id") REFERENCES "promotion" ("id");

ALTER TABLE "bundled_dis" ADD FOREIGN KEY ("promotion_id") REFERENCES "promotion" ("id");

ALTER TABLE "bundled_dis" ADD FOREIGN KEY ("bundle_product_id") REFERENCES "product" ("id");

ALTER TABLE "volume_dis" ADD FOREIGN KEY ("promotion_id") REFERENCES "promotion" ("id");

ALTER TABLE "promotion_config" ADD FOREIGN KEY ("product_id") REFERENCES "product" ("id");

ALTER TABLE "promotion_config" ADD FOREIGN KEY ("promotion_id") REFERENCES "promotion" ("id");