-- =============================================================================
-- Ryzera POS - Historical Multi-Branch Transactions Seed (Sep 12 - Sep 15, 2026)
-- Run this in Supabase SQL Editor, DBeaver, or psql to populate your reports!
-- =============================================================================

DO $$
DECLARE
    v_hq_id INT;
    v_kdy_id INT;
    v_cashier_id INT;
    v_kandy_mgr_id INT;
    v_admin_id INT;

    v_prod_rice INT;
    v_prod_milk INT;
    v_prod_coke INT;
    v_prod_earbuds INT;
    v_prod_cable INT;
    v_prod_tshirt INT;
    v_prod_jeans INT;
    v_prod_tea INT;
    v_prod_cheese INT;
    v_prod_polo INT;
    v_prod_cleaner INT;
    v_prod_soap INT;
    v_prod_chips INT;
    v_prod_paper INT;

    v_sale_id INT;
    v_item_id INT;
BEGIN
    -- 1. Look up Branches
    SELECT branch_id INTO v_hq_id FROM "branch" WHERE "code" = 'HQ' LIMIT 1;
    SELECT branch_id INTO v_kdy_id FROM "branch" WHERE "code" = 'KDY' LIMIT 1;
    IF v_hq_id IS NULL THEN SELECT branch_id INTO v_hq_id FROM "branch" LIMIT 1; END IF;
    IF v_kdy_id IS NULL THEN v_kdy_id := v_hq_id; END IF;

    -- 2. Look up Users
    SELECT user_id INTO v_admin_id FROM "user" WHERE "username" = 'admin' LIMIT 1;
    SELECT user_id INTO v_cashier_id FROM "user" WHERE "username" = 'cashier_hq' LIMIT 1;
    SELECT user_id INTO v_kandy_mgr_id FROM "user" WHERE "username" = 'manager_kandy' LIMIT 1;
    IF v_cashier_id IS NULL THEN v_cashier_id := v_admin_id; END IF;
    IF v_kandy_mgr_id IS NULL THEN v_kandy_mgr_id := v_admin_id; END IF;

    -- 3. Look up Products (or create placeholders)
    SELECT product_id INTO v_prod_rice FROM "product" WHERE sku = 'RC-002' OR name ILIKE '%Basmati%' LIMIT 1;
    SELECT product_id INTO v_prod_milk FROM "product" WHERE sku = 'FM-001' OR name ILIKE '%Milk%' LIMIT 1;
    SELECT product_id INTO v_prod_coke FROM "product" WHERE sku IN ('CC-330', 'BEV001') OR name ILIKE '%Cola%' LIMIT 1;
    SELECT product_id INTO v_prod_earbuds FROM "product" WHERE sku = 'WE-001' OR name ILIKE '%Earbuds%' LIMIT 1;
    SELECT product_id INTO v_prod_cable FROM "product" WHERE sku = 'UC-003' OR name ILIKE '%Cable%' LIMIT 1;
    SELECT product_id INTO v_prod_tshirt FROM "product" WHERE sku = 'TS-001' OR name ILIKE '%T-Shirt%' LIMIT 1;
    SELECT product_id INTO v_prod_jeans FROM "product" WHERE sku = 'JN-002' OR name ILIKE '%Jeans%' LIMIT 1;
    SELECT product_id INTO v_prod_tea FROM "product" WHERE sku = 'TB-004' OR name ILIKE '%Tea%' LIMIT 1;
    SELECT product_id INTO v_prod_cheese FROM "product" WHERE sku = 'CC-002' OR name ILIKE '%Cheese%' LIMIT 1;
    SELECT product_id INTO v_prod_polo FROM "product" WHERE sku = 'PS-003' OR name ILIKE '%Polo%' LIMIT 1;
    SELECT product_id INTO v_prod_cleaner FROM "product" WHERE sku = 'FC-001' OR name ILIKE '%Cleaner%' LIMIT 1;
    SELECT product_id INTO v_prod_soap FROM "product" WHERE sku = 'DS-002' OR name ILIKE '%Soap%' LIMIT 1;
    SELECT product_id INTO v_prod_chips FROM "product" WHERE sku = 'SNK002' OR name ILIKE '%Chips%' LIMIT 1;
    SELECT product_id INTO v_prod_paper FROM "product" WHERE sku = 'STN001' OR name ILIKE '%Paper%' LIMIT 1;

    -- =========================================================================
    -- SEPTEMBER 12, 2026
    -- =========================================================================
    IF NOT EXISTS (SELECT 1 FROM "sale" WHERE invoice_number = 'INV-2026-0912-001') THEN
        INSERT INTO "sale" (branch_id, user_id, invoice_number, sale_status, payment_status, subtotal, discount_amount, tax_amount, total_amount, created_at, updated_at)
        VALUES (v_hq_id, v_cashier_id, 'INV-2026-0912-001', 'Completed', 'Paid', 4560.00, 0.00, 0.00, 4560.00, '2026-09-12 09:15:00', '2026-09-12 09:15:00')
        RETURNING sale_id INTO v_sale_id;

        INSERT INTO "sale_item" (sale_id, product_id, product_name, quantity, unit, unit_price, cost_price, discount_percent, discount_amount, tax_percent, tax_amount, subtotal, total_amount, created_at)
        VALUES 
        (v_sale_id, v_prod_rice, 'Basmati Rice 5kg', 2, 'PCS', 1200.00, 900.00, 0, 0, 0, 0, 2400.00, 2400.00, '2026-09-12 09:15:00'),
        (v_sale_id, v_prod_milk, 'Full Cream Milk 1L', 3, 'PCS', 480.00, 360.00, 0, 0, 0, 0, 1440.00, 1440.00, '2026-09-12 09:15:00'),
        (v_sale_id, v_prod_coke, 'Coca Cola 330ml', 4, 'PCS', 180.00, 110.00, 0, 0, 0, 0, 720.00, 720.00, '2026-09-12 09:15:00');

        INSERT INTO "payment" (sale_id, payment_method, amount_paid, payment_status, payment_date, created_at)
        VALUES (v_sale_id, 'CASH', 4560.00, 'Paid', '2026-09-12 09:15:00', '2026-09-12 09:15:00');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM "sale" WHERE invoice_number = 'INV-2026-0912-002') THEN
        INSERT INTO "sale" (branch_id, user_id, invoice_number, sale_status, payment_status, subtotal, discount_amount, tax_amount, total_amount, created_at, updated_at)
        VALUES (v_hq_id, v_cashier_id, 'INV-2026-0912-002', 'Completed', 'Paid', 5800.00, 225.00, 0.00, 5575.00, '2026-09-12 11:45:00', '2026-09-12 11:45:00')
        RETURNING sale_id INTO v_sale_id;

        INSERT INTO "sale_item" (sale_id, product_id, product_name, quantity, unit, unit_price, cost_price, discount_percent, discount_amount, tax_percent, tax_amount, subtotal, total_amount, created_at)
        VALUES 
        (v_sale_id, v_prod_earbuds, 'Wireless Earbuds', 1, 'PCS', 4500.00, 3100.00, 5, 225.00, 0, 0, 4500.00, 4275.00, '2026-09-12 11:45:00'),
        (v_sale_id, v_prod_cable, 'USB-C Cable 2m', 2, 'PCS', 650.00, 380.00, 0, 0, 0, 0, 1300.00, 1300.00, '2026-09-12 11:45:00');

        INSERT INTO "payment" (sale_id, payment_method, amount_paid, payment_status, payment_date, created_at)
        VALUES (v_sale_id, 'CARD', 5575.00, 'Paid', '2026-09-12 11:45:00', '2026-09-12 11:45:00');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM "sale" WHERE invoice_number = 'INV-2026-0912-003') THEN
        INSERT INTO "sale" (branch_id, user_id, invoice_number, sale_status, payment_status, subtotal, discount_amount, tax_amount, total_amount, created_at, updated_at)
        VALUES (v_kdy_id, v_kandy_mgr_id, 'INV-2026-0912-003', 'Completed', 'Paid', 6200.00, 0.00, 0.00, 6200.00, '2026-09-12 14:20:00', '2026-09-12 14:20:00')
        RETURNING sale_id INTO v_sale_id;

        INSERT INTO "sale_item" (sale_id, product_id, product_name, quantity, unit, unit_price, cost_price, discount_percent, discount_amount, tax_percent, tax_amount, subtotal, total_amount, created_at)
        VALUES 
        (v_sale_id, v_prod_tshirt, 'T-Shirt — Medium', 2, 'PCS', 1500.00, 950.00, 0, 0, 0, 0, 3000.00, 3000.00, '2026-09-12 14:20:00'),
        (v_sale_id, v_prod_jeans, 'Slim Fit Jeans', 1, 'PCS', 3200.00, 2100.00, 0, 0, 0, 0, 3200.00, 3200.00, '2026-09-12 14:20:00');

        INSERT INTO "payment" (sale_id, payment_method, amount_paid, payment_status, payment_date, created_at)
        VALUES (v_sale_id, 'CASH', 6200.00, 'Paid', '2026-09-12 14:20:00', '2026-09-12 14:20:00');
    END IF;

    -- =========================================================================
    -- SEPTEMBER 13, 2026
    -- =========================================================================
    IF NOT EXISTS (SELECT 1 FROM "sale" WHERE invoice_number = 'INV-2026-0913-001') THEN
        INSERT INTO "sale" (branch_id, user_id, invoice_number, sale_status, payment_status, subtotal, discount_amount, tax_amount, total_amount, created_at, updated_at)
        VALUES (v_hq_id, v_cashier_id, 'INV-2026-0913-001', 'Completed', 'Paid', 4720.00, 0.00, 0.00, 4720.00, '2026-09-13 10:10:00', '2026-09-13 10:10:00')
        RETURNING sale_id INTO v_sale_id;

        INSERT INTO "sale_item" (sale_id, product_id, product_name, quantity, unit, unit_price, cost_price, discount_percent, discount_amount, tax_percent, tax_amount, subtotal, total_amount, created_at)
        VALUES 
        (v_sale_id, v_prod_polo, 'Polo Shirt XL', 2, 'PCS', 1800.00, 1150.00, 0, 0, 0, 0, 3600.00, 3600.00, '2026-09-13 10:10:00'),
        (v_sale_id, v_prod_cleaner, 'Floor Cleaner 1L', 2, 'PCS', 275.00, 180.00, 0, 0, 0, 0, 550.00, 550.00, '2026-09-13 10:10:00'),
        (v_sale_id, v_prod_soap, 'Dish Soap 500ml', 3, 'PCS', 190.00, 130.00, 0, 0, 0, 0, 570.00, 570.00, '2026-09-13 10:10:00')
        RETURNING sale_item_id INTO v_item_id;

        INSERT INTO "payment" (sale_id, payment_method, amount_paid, payment_status, payment_date, created_at)
        VALUES (v_sale_id, 'CARD', 4720.00, 'Paid', '2026-09-13 10:10:00', '2026-09-13 10:10:00');

        -- Customer Return Example (Dish Soap)
        INSERT INTO "return" (sale_id, return_date, return_type, return_amount, reason, refund_method, status, created_at, updated_at)
        VALUES (v_sale_id, '2026-09-13 11:30:00', 'Partial', 190.00, 'Customer bought wrong fragrance', 'Cash', 'Completed', '2026-09-13 11:30:00', '2026-09-13 11:30:00')
        RETURNING return_id INTO v_item_id;

        INSERT INTO "return_item" (return_id, sale_item_id, quantity_returned, unit_price, refund_amount, item_condition, created_at)
        VALUES (v_item_id, v_item_id, 1, 190.00, 190.00, 'Good', '2026-09-13 11:30:00');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM "sale" WHERE invoice_number = 'INV-2026-0913-002') THEN
        INSERT INTO "sale" (branch_id, user_id, invoice_number, sale_status, payment_status, subtotal, discount_amount, tax_amount, total_amount, created_at, updated_at)
        VALUES (v_hq_id, v_cashier_id, 'INV-2026-0913-002', 'Completed', 'Paid', 4680.00, 360.00, 0.00, 4320.00, '2026-09-13 13:30:00', '2026-09-13 13:30:00')
        RETURNING sale_id INTO v_sale_id;

        INSERT INTO "sale_item" (sale_id, product_id, product_name, quantity, unit, unit_price, cost_price, discount_percent, discount_amount, tax_percent, tax_amount, subtotal, total_amount, created_at)
        VALUES 
        (v_sale_id, v_prod_rice, 'Basmati Rice 5kg', 3, 'PCS', 1200.00, 900.00, 10, 360.00, 0, 0, 3600.00, 3240.00, '2026-09-13 13:30:00'),
        (v_sale_id, v_prod_coke, 'Coca Cola 330ml', 6, 'PCS', 180.00, 110.00, 0, 0, 0, 0, 1080.00, 1080.00, '2026-09-13 13:30:00');

        INSERT INTO "payment" (sale_id, payment_method, amount_paid, payment_status, payment_date, created_at)
        VALUES (v_sale_id, 'CASH', 4320.00, 'Paid', '2026-09-13 13:30:00', '2026-09-13 13:30:00');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM "sale" WHERE invoice_number = 'INV-2026-0913-003') THEN
        INSERT INTO "sale" (branch_id, user_id, invoice_number, sale_status, payment_status, subtotal, discount_amount, tax_amount, total_amount, created_at, updated_at)
        VALUES (v_kdy_id, v_kandy_mgr_id, 'INV-2026-0913-003', 'Completed', 'Paid', 6420.00, 0.00, 0.00, 6420.00, '2026-09-13 15:15:00', '2026-09-13 15:15:00')
        RETURNING sale_id INTO v_sale_id;

        INSERT INTO "sale_item" (sale_id, product_id, product_name, quantity, unit, unit_price, cost_price, discount_percent, discount_amount, tax_percent, tax_amount, subtotal, total_amount, created_at)
        VALUES 
        (v_sale_id, v_prod_earbuds, 'Wireless Earbuds', 1, 'PCS', 4500.00, 3100.00, 0, 0, 0, 0, 4500.00, 4500.00, '2026-09-13 15:15:00'),
        (v_sale_id, v_prod_milk, 'Full Cream Milk 1L', 4, 'PCS', 480.00, 360.00, 0, 0, 0, 0, 1920.00, 1920.00, '2026-09-13 15:15:00');

        INSERT INTO "payment" (sale_id, payment_method, amount_paid, payment_status, payment_date, created_at)
        VALUES (v_sale_id, 'CARD', 6420.00, 'Paid', '2026-09-13 15:15:00', '2026-09-13 15:15:00');
    END IF;

    -- =========================================================================
    -- SEPTEMBER 14, 2026
    -- =========================================================================
    IF NOT EXISTS (SELECT 1 FROM "sale" WHERE invoice_number = 'INV-2026-0914-001') THEN
        INSERT INTO "sale" (branch_id, user_id, invoice_number, sale_status, payment_status, subtotal, discount_amount, tax_amount, total_amount, created_at, updated_at)
        VALUES (v_hq_id, v_cashier_id, 'INV-2026-0914-001', 'Completed', 'Paid', 6700.00, 0.00, 0.00, 6700.00, '2026-09-14 09:40:00', '2026-09-14 09:40:00')
        RETURNING sale_id INTO v_sale_id;

        INSERT INTO "sale_item" (sale_id, product_id, product_name, quantity, unit, unit_price, cost_price, discount_percent, discount_amount, tax_percent, tax_amount, subtotal, total_amount, created_at)
        VALUES 
        (v_sale_id, v_prod_paper, 'A4 Paper Pack', 5, 'PCS', 950.00, 750.00, 0, 0, 0, 0, 4750.00, 4750.00, '2026-09-14 09:40:00'),
        (v_sale_id, v_prod_cable, 'USB-C Cable 2m', 3, 'PCS', 650.00, 380.00, 0, 0, 0, 0, 1950.00, 1950.00, '2026-09-14 09:40:00');

        INSERT INTO "payment" (sale_id, payment_method, amount_paid, payment_status, payment_date, created_at)
        VALUES (v_sale_id, 'CASH', 6700.00, 'Paid', '2026-09-14 09:40:00', '2026-09-14 09:40:00');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM "sale" WHERE invoice_number = 'INV-2026-0914-002') THEN
        INSERT INTO "sale" (branch_id, user_id, invoice_number, sale_status, payment_status, subtotal, discount_amount, tax_amount, total_amount, created_at, updated_at)
        VALUES (v_kdy_id, v_kandy_mgr_id, 'INV-2026-0914-002', 'Completed', 'Paid', 10900.00, 450.00, 0.00, 10450.00, '2026-09-14 12:25:00', '2026-09-14 12:25:00')
        RETURNING sale_id INTO v_sale_id;

        INSERT INTO "sale_item" (sale_id, product_id, product_name, quantity, unit, unit_price, cost_price, discount_percent, discount_amount, tax_percent, tax_amount, subtotal, total_amount, created_at)
        VALUES 
        (v_sale_id, v_prod_jeans, 'Slim Fit Jeans', 2, 'PCS', 3200.00, 2100.00, 0, 0, 0, 0, 6400.00, 6400.00, '2026-09-14 12:25:00'),
        (v_sale_id, v_prod_tshirt, 'T-Shirt — Medium', 3, 'PCS', 1500.00, 950.00, 10, 450.00, 0, 0, 4500.00, 4050.00, '2026-09-14 12:25:00');

        INSERT INTO "payment" (sale_id, payment_method, amount_paid, payment_status, payment_date, created_at)
        VALUES (v_sale_id, 'CARD', 10450.00, 'Paid', '2026-09-14 12:25:00', '2026-09-14 12:25:00');
    END IF;

    -- =========================================================================
    -- SEPTEMBER 15, 2026 (TODAY)
    -- =========================================================================
    IF NOT EXISTS (SELECT 1 FROM "sale" WHERE invoice_number = 'INV-2026-0915-001') THEN
        INSERT INTO "sale" (branch_id, user_id, invoice_number, sale_status, payment_status, subtotal, discount_amount, tax_amount, total_amount, created_at, updated_at)
        VALUES (v_hq_id, v_cashier_id, 'INV-2026-0915-001', 'Completed', 'Paid', 3460.00, 0.00, 0.00, 3460.00, '2026-09-15 08:30:00', '2026-09-15 08:30:00')
        RETURNING sale_id INTO v_sale_id;

        INSERT INTO "sale_item" (sale_id, product_id, product_name, quantity, unit, unit_price, cost_price, discount_percent, discount_amount, tax_percent, tax_amount, subtotal, total_amount, created_at)
        VALUES 
        (v_sale_id, v_prod_milk, 'Full Cream Milk 1L', 4, 'PCS', 480.00, 360.00, 0, 0, 0, 0, 1920.00, 1920.00, '2026-09-15 08:30:00'),
        (v_sale_id, v_prod_tea, 'Green Tea Bags x20', 2, 'PCS', 320.00, 220.00, 0, 0, 0, 0, 640.00, 640.00, '2026-09-15 08:30:00'),
        (v_sale_id, v_prod_coke, 'Coca Cola 330ml', 5, 'PCS', 180.00, 110.00, 0, 0, 0, 0, 900.00, 900.00, '2026-09-15 08:30:00');

        INSERT INTO "payment" (sale_id, payment_method, amount_paid, payment_status, payment_date, created_at)
        VALUES (v_sale_id, 'CASH', 3460.00, 'Paid', '2026-09-15 08:30:00', '2026-09-15 08:30:00');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM "sale" WHERE invoice_number = 'INV-2026-0915-002') THEN
        INSERT INTO "sale" (branch_id, user_id, invoice_number, sale_status, payment_status, subtotal, discount_amount, tax_amount, total_amount, created_at, updated_at)
        VALUES (v_kdy_id, v_kandy_mgr_id, 'INV-2026-0915-002', 'Completed', 'Paid', 6900.00, 225.00, 0.00, 6675.00, '2026-09-15 10:50:00', '2026-09-15 10:50:00')
        RETURNING sale_id INTO v_sale_id;

        INSERT INTO "sale_item" (sale_id, product_id, product_name, quantity, unit, unit_price, cost_price, discount_percent, discount_amount, tax_percent, tax_amount, subtotal, total_amount, created_at)
        VALUES 
        (v_sale_id, v_prod_rice, 'Basmati Rice 5kg', 2, 'PCS', 1200.00, 900.00, 0, 0, 0, 0, 2400.00, 2400.00, '2026-09-15 10:50:00'),
        (v_sale_id, v_prod_earbuds, 'Wireless Earbuds', 1, 'PCS', 4500.00, 3100.00, 5, 225.00, 0, 0, 4500.00, 4275.00, '2026-09-15 10:50:00');

        INSERT INTO "payment" (sale_id, payment_method, amount_paid, payment_status, payment_date, created_at)
        VALUES (v_sale_id, 'CARD', 6675.00, 'Paid', '2026-09-15 10:50:00', '2026-09-15 10:50:00');
    END IF;

    RAISE NOTICE '✅ Successfully seeded historical transactions from Sep 12 to Sep 15, 2026!';
END $$;
