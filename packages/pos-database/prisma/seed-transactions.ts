import 'dotenv/config';
import pg from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '../src/generated/prisma';

const pool = new pg.Pool({
    connectionString: process.env.DATABASE_URL,
});
const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter } as any);

interface SeedItem {
    name: string;
    sku: string;
    qty: number;
    price: number;
    cost: number;
    discountPct?: number;
}

interface SeedSale {
    invoice: string;
    branchCode: string;
    cashierUsername: string;
    date: string; // ISO string e.g. "2026-09-12T10:30:00Z"
    paymentMethod: 'CASH' | 'CARD' | 'SPLIT';
    items: SeedItem[];
    taxPercent?: number;
    hasReturn?: {
        returnQty: number;
        reason: string;
        itemIndex: number;
    };
}

const TRANSACTIONS: SeedSale[] = [
    // ═════════════════════════════════════════════════════════════════════
    // SEPTEMBER 12, 2026
    // ═════════════════════════════════════════════════════════════════════
    {
        invoice: 'INV-2026-0912-001',
        branchCode: 'HQ',
        cashierUsername: 'cashier_hq',
        date: '2026-09-12T09:15:00.000Z',
        paymentMethod: 'CASH',
        items: [
            { name: 'Basmati Rice 5kg', sku: 'RC-002', qty: 2, price: 1200, cost: 900 },
            { name: 'Full Cream Milk 1L', sku: 'FM-001', qty: 3, price: 480, cost: 360 },
            { name: 'Coca Cola 330ml', sku: 'CC-330', qty: 4, price: 180, cost: 110 },
        ],
    },
    {
        invoice: 'INV-2026-0912-002',
        branchCode: 'HQ',
        cashierUsername: 'cashier_hq',
        date: '2026-09-12T11:45:00.000Z',
        paymentMethod: 'CARD',
        items: [
            { name: 'Wireless Earbuds', sku: 'WE-001', qty: 1, price: 4500, cost: 3100, discountPct: 5 },
            { name: 'USB-C Cable 2m', sku: 'UC-003', qty: 2, price: 650, cost: 380 },
        ],
    },
    {
        invoice: 'INV-2026-0912-003',
        branchCode: 'KDY',
        cashierUsername: 'manager_kandy',
        date: '2026-09-12T14:20:00.000Z',
        paymentMethod: 'CASH',
        items: [
            { name: 'T-Shirt — Medium', sku: 'TS-001', qty: 2, price: 1500, cost: 950 },
            { name: 'Slim Fit Jeans', sku: 'JN-002', qty: 1, price: 3200, cost: 2100 },
        ],
    },
    {
        invoice: 'INV-2026-0912-004',
        branchCode: 'KDY',
        cashierUsername: 'manager_kandy',
        date: '2026-09-12T16:50:00.000Z',
        paymentMethod: 'CARD',
        items: [
            { name: 'Green Tea Bags x20', sku: 'TB-004', qty: 4, price: 320, cost: 220 },
            { name: 'Cheddar Cheese 200g', sku: 'CC-002', qty: 2, price: 890, cost: 680 },
        ],
    },

    // ═════════════════════════════════════════════════════════════════════
    // SEPTEMBER 13, 2026
    // ═════════════════════════════════════════════════════════════════════
    {
        invoice: 'INV-2026-0913-001',
        branchCode: 'HQ',
        cashierUsername: 'cashier_hq',
        date: '2026-09-13T10:10:00.000Z',
        paymentMethod: 'CARD',
        items: [
            { name: 'Polo Shirt XL', sku: 'PS-003', qty: 2, price: 1800, cost: 1150 },
            { name: 'Floor Cleaner 1L', sku: 'FC-001', qty: 2, price: 275, cost: 180 },
            { name: 'Dish Soap 500ml', sku: 'DS-002', qty: 3, price: 190, cost: 130 },
        ],
        hasReturn: {
            itemIndex: 1, // Floor Cleaner
            returnQty: 1,
            reason: 'Customer bought incorrect variant',
        },
    },
    {
        invoice: 'INV-2026-0913-002',
        branchCode: 'HQ',
        cashierUsername: 'cashier_hq',
        date: '2026-09-13T13:30:00.000Z',
        paymentMethod: 'CASH',
        items: [
            { name: 'Basmati Rice 5kg', sku: 'RC-002', qty: 3, price: 1200, cost: 900, discountPct: 10 },
            { name: 'Coca Cola 330ml', sku: 'CC-330', qty: 6, price: 180, cost: 110 },
        ],
    },
    {
        invoice: 'INV-2026-0913-003',
        branchCode: 'KDY',
        cashierUsername: 'manager_kandy',
        date: '2026-09-13T15:15:00.000Z',
        paymentMethod: 'CARD',
        items: [
            { name: 'Wireless Earbuds', sku: 'WE-001', qty: 1, price: 4500, cost: 3100 },
            { name: 'Full Cream Milk 1L', sku: 'FM-001', qty: 4, price: 480, cost: 360 },
        ],
    },
    {
        invoice: 'INV-2026-0913-004',
        branchCode: 'KDY',
        cashierUsername: 'manager_kandy',
        date: '2026-09-13T18:00:00.000Z',
        paymentMethod: 'CASH',
        items: [
            { name: 'Chips Pack', sku: 'SNK002', qty: 10, price: 95, cost: 60 },
            { name: 'Coca Cola 330ml', sku: 'CC-330', qty: 8, price: 180, cost: 110 },
        ],
    },

    // ═════════════════════════════════════════════════════════════════════
    // SEPTEMBER 14, 2026
    // ═════════════════════════════════════════════════════════════════════
    {
        invoice: 'INV-2026-0914-001',
        branchCode: 'HQ',
        cashierUsername: 'cashier_hq',
        date: '2026-09-14T09:40:00.000Z',
        paymentMethod: 'CASH',
        items: [
            { name: 'A4 Paper Pack', sku: 'STN001', qty: 5, price: 950, cost: 750 },
            { name: 'USB-C Cable 2m', sku: 'UC-003', qty: 3, price: 650, cost: 380 },
        ],
    },
    {
        invoice: 'INV-2026-0914-002',
        branchCode: 'HQ',
        cashierUsername: 'cashier_hq',
        date: '2026-09-14T12:25:00.000Z',
        paymentMethod: 'CARD',
        items: [
            { name: 'Slim Fit Jeans', sku: 'JN-002', qty: 2, price: 3200, cost: 2100 },
            { name: 'T-Shirt — Medium', sku: 'TS-001', qty: 3, price: 1500, cost: 950, discountPct: 10 },
        ],
    },
    {
        invoice: 'INV-2026-0914-003',
        branchCode: 'KDY',
        cashierUsername: 'manager_kandy',
        date: '2026-09-14T14:45:00.000Z',
        paymentMethod: 'CASH',
        items: [
            { name: 'Basmati Rice 5kg', sku: 'RC-002', qty: 4, price: 1200, cost: 900 },
            { name: 'Cheddar Cheese 200g', sku: 'CC-002', qty: 3, price: 890, cost: 680 },
        ],
    },
    {
        invoice: 'INV-2026-0914-004',
        branchCode: 'KDY',
        cashierUsername: 'manager_kandy',
        date: '2026-09-14T17:30:00.000Z',
        paymentMethod: 'CARD',
        items: [
            { name: 'Polo Shirt XL', sku: 'PS-003', qty: 1, price: 1800, cost: 1150 },
            { name: 'Wireless Earbuds', sku: 'WE-001', qty: 1, price: 4500, cost: 3100 },
        ],
    },

    // ═════════════════════════════════════════════════════════════════════
    // SEPTEMBER 15, 2026 (TODAY)
    // ═════════════════════════════════════════════════════════════════════
    {
        invoice: 'INV-2026-0915-001',
        branchCode: 'HQ',
        cashierUsername: 'cashier_hq',
        date: '2026-09-15T08:30:00.000Z',
        paymentMethod: 'CASH',
        items: [
            { name: 'Full Cream Milk 1L', sku: 'FM-001', qty: 4, price: 480, cost: 360 },
            { name: 'Green Tea Bags x20', sku: 'TB-004', qty: 2, price: 320, cost: 220 },
            { name: 'Coca Cola 330ml', sku: 'CC-330', qty: 5, price: 180, cost: 110 },
        ],
    },
    {
        invoice: 'INV-2026-0915-002',
        branchCode: 'HQ',
        cashierUsername: 'cashier_hq',
        date: '2026-09-15T10:50:00.000Z',
        paymentMethod: 'CARD',
        items: [
            { name: 'Basmati Rice 5kg', sku: 'RC-002', qty: 2, price: 1200, cost: 900 },
            { name: 'Wireless Earbuds', sku: 'WE-001', qty: 1, price: 4500, cost: 3100, discountPct: 5 },
        ],
    },
    {
        invoice: 'INV-2026-0915-003',
        branchCode: 'KDY',
        cashierUsername: 'manager_kandy',
        date: '2026-09-15T11:15:00.000Z',
        paymentMethod: 'CASH',
        items: [
            { name: 'T-Shirt — Medium', sku: 'TS-001', qty: 2, price: 1500, cost: 950 },
            { name: 'Slim Fit Jeans', sku: 'JN-002', qty: 1, price: 3200, cost: 2100 },
            { name: 'Polo Shirt XL', sku: 'PS-003', qty: 1, price: 1800, cost: 1150 },
        ],
    },
    {
        invoice: 'INV-2026-0915-004',
        branchCode: 'KDY',
        cashierUsername: 'manager_kandy',
        date: '2026-09-15T12:40:00.000Z',
        paymentMethod: 'CARD',
        items: [
            { name: 'Floor Cleaner 1L', sku: 'FC-001', qty: 3, price: 275, cost: 180 },
            { name: 'Dish Soap 500ml', sku: 'DS-002', qty: 4, price: 190, cost: 130 },
            { name: 'Chips Pack', sku: 'SNK002', qty: 6, price: 95, cost: 60 },
        ],
    },
];

async function main() {
    console.log('🚀 Seeding Historical Transactions (Sep 12 - Sep 15, 2026)...');

    const branches = await prisma.branch.findMany();
    const users = await prisma.user.findMany();
    const allProducts = await prisma.product.findMany();

    const branchMap = new Map(branches.map((b: any) => [b.code, b]));
    const userMap = new Map(users.map((u: any) => [u.username, u]));
    const productSkuMap = new Map(allProducts.map((p: any) => [p.sku, p]));
    const productNameMap = new Map(allProducts.map((p: any) => [p.name.toLowerCase(), p]));

    let createdCount = 0;

    for (const t of TRANSACTIONS) {
        let branch = branchMap.get(t.branchCode);
        if (!branch) {
            branch = branches[0];
        }
        if (!branch) continue;

        let user = userMap.get(t.cashierUsername);
        if (!user) {
            user = users[0];
        }
        if (!user) continue;

        const existing = await prisma.sale.findUnique({
            where: { invoice_number: t.invoice },
        });
        if (existing) {
            console.log(`⏩ Skipping existing sale ${t.invoice}`);
            continue;
        }

        const saleDate = new Date(t.date);

        let subtotal = 0;
        let totalDiscount = 0;
        let totalTax = 0;

        const preparedItems: any[] = [];

        for (const it of t.items) {
            let product = productSkuMap.get(it.sku) || productNameMap.get(it.name.toLowerCase());
            
            if (!product) {
                product = await prisma.product.create({
                    data: {
                        name: it.name,
                        code: it.sku,
                        sku: it.sku,
                        price: it.price,
                        cost_price: it.cost,
                        company_id: branch.company_id,
                        unit: 'PCS',
                        status: 'ACTIVE',
                    },
                });
                productSkuMap.set(it.sku, product);
            }

            const itemSubtotal = it.qty * it.price;
            const discountPct = it.discountPct || 0;
            const itemDiscount = (itemSubtotal * discountPct) / 100;
            const itemTax = 0;
            const itemTotal = itemSubtotal - itemDiscount + itemTax;

            subtotal += itemSubtotal;
            totalDiscount += itemDiscount;
            totalTax += itemTax;

            preparedItems.push({
                product_id: product.id,
                product_name: product.name,
                quantity: it.qty,
                unit: 'PCS',
                unit_price: it.price,
                cost_price: it.cost,
                discount_percent: discountPct,
                discount_amount: itemDiscount,
                tax_percent: 0,
                tax_amount: 0,
                subtotal: itemSubtotal,
                total_amount: itemTotal,
                created_at: saleDate,
            });
        }

        const totalAmount = subtotal - totalDiscount + totalTax;

        // 1. Create Sale + SaleItems
        const createdSale = await prisma.sale.create({
            data: {
                branch_id: branch.id,
                user_id: user.id,
                invoice_number: t.invoice,
                sale_status: 'Completed',
                payment_status: 'Paid',
                subtotal,
                discount_amount: totalDiscount,
                tax_amount: totalTax,
                total_amount: totalAmount,
                created_at: saleDate,
                updated_at: saleDate,
                saleItems: {
                    create: preparedItems,
                },
            },
            include: {
                saleItems: true,
            },
        });

        // 2. Create Payment
        await prisma.payment.create({
            data: {
                sale_id: createdSale.id,
                payment_method: t.paymentMethod,
                amount_paid: totalAmount,
                payment_status: 'Paid',
                payment_date: saleDate,
                created_at: saleDate,
            },
        });

        // 3. Create Return if specified
        if (t.hasReturn && createdSale.saleItems[t.hasReturn.itemIndex]) {
            const returnItemTarget = createdSale.saleItems[t.hasReturn.itemIndex];
            const refundAmount = Number(returnItemTarget.unit_price) * t.hasReturn.returnQty;

            await prisma.return.create({
                data: {
                    sale_id: createdSale.id,
                    return_date: saleDate,
                    return_type: 'Partial',
                    return_amount: refundAmount,
                    reason: t.hasReturn.reason,
                    refund_method: t.paymentMethod === 'CARD' ? 'Card' : 'Cash',
                    status: 'Completed',
                    created_at: saleDate,
                    updated_at: saleDate,
                    returnItems: {
                        create: [
                            {
                                sale_item_id: returnItemTarget.id,
                                quantity_returned: t.hasReturn.returnQty,
                                unit_price: returnItemTarget.unit_price,
                                refund_amount: refundAmount,
                                item_condition: 'Good',
                                created_at: saleDate,
                            },
                        ],
                    },
                },
            });
            console.log(`   ↩️ Return logged for ${t.invoice}: ${refundAmount} LKR`);
        }

        createdCount++;
        console.log(`✅ Created ${t.invoice} (${t.branchCode}) — ${totalAmount} LKR on ${t.date.slice(0, 10)}`);
    }

    console.log(`\n🎉 Successfully seeded ${createdCount} multi-branch transactions from Sep 12 to Sep 15, 2026!`);
}

main()
    .catch((e) => {
        console.error('❌ Seeding failed:', e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
        await pool.end();
    });
