-- Create orders table
CREATE TABLE orders (
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_date DATE,
    product_id VARCHAR(255),
    unit_price INT,
    quantity INT,
    total_price INT,
    PRIMARY KEY (order_id)
);

-- Create shipment_deliveries table
CREATE TABLE shipment_deliveries (
    shipment_id INT NOT NULL,
    order_id INT,
    shipment_date DATE,
    delivery_date DATE,
    PRIMARY KEY (shipment_id)
);

-- Create reviews table
CREATE TABLE reviews (
    review INT,
    product_id INT,
    PRIMARY KEY (review)
);

-- Add foreign key constraint to 'orders' table
ALTER TABLE orders ADD CONSTRAINT orders_customer_fk
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id);

-- Add foreign key constraint to 'shipment_deliveries' table
ALTER TABLE shipment_deliveries ADD CONSTRAINT shipment_deliveries_order_fk
    FOREIGN KEY (order_id) REFERENCES orders (order_id);

-- Add foreign key constraint to 'reviews' table
ALTER TABLE reviews ADD CONSTRAINT reviews_product_fk
    FOREIGN KEY (product_id) REFERENCES products (product_id);

