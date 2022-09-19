const Cart_Items = require('./Cart_Items');
const Customer_Address = require('./Customer_Address');
const Customer_Payment = require('./Customer_Payment');
const Customer = require('./Customer');
const Order_Details = require('./Order_Details');
const Order_Items = require('./Order_Items');
const Payment_Details = require('./Payment_Details');
const Product_Category = require('./Product_Category');
const Product_Discount = require('./Product_Discount');
const Product_Inventory = require('./Product_Inventory');
const Product = require('./Product');
const Shopping_Session = require('./Shopping_Session');

// Develop associations here
Customer.hasMany(Customer_Address, {
    foreignKey: 'customer_id'
});
Customer_Address.belongsTo(Customer, {
    foreignKey: 'customer_id'
});
Customer.hasMany(Customer_Payment, {
    foreignKey: 'customer_id'
});
Customer_Payment.belongsTo(Customer, {
    foreignKey: 'customer_id'
});
Customer.hasMany(Order_Details, {
    foreignKey: 'customer_id'
});
Order_Details.belongsTo(Customer, {
    foreignKey: 'customer_id'
});
// ERD diagram initially showed this relationship
// as 1:m, i.e. a customer can have many shopping sessions
// which is wrong, a customer will only have 1 shopping session
Customer.hasOne(Shopping_Session, {
    foreignKey: 'customer_id'
});
Shopping_Session.belongsTo(Customer, {
    foreignKey: 'customer_id'
});
Shopping_Session.hasMany(Cart_Items, {
    foreignKey: 'session_id'
});
Cart_Items.belongsTo(Shopping_Session, {
    foreignKey: 'session_id'
});
Product.hasMany(Order_Details, {
    through: Order_Items,
    as: 'NOT_SURE_YET',
    foreignKey: 'product_id'
});
Order_Details.hasMany(Product, {
    through: Order_Items,
    as: 'NOT_SURE_YET',
    foreignKey: 'order_id'
});
// ERD diagram initially showed this relationship
// as 1:m, i.e. a payment detail can have many orders
// which is wrong, a payment transaction will only have 1 order
Order_Details.hasOne(Payment_Details, {
    foreignKey: 'order_id'
});
Payment_Details.belongsTo(Order_Details, {
    foreignKey: 'order_id'
});
Product_Category.hasMany(Product, {
    foreignKey: 'category_id'
});
Product.belongsTo(Product_Category, {
    foreignKey: 'category_id'
});
Product_Inventory.hasMany(Product, {
    foreignKey: 'inventory_id'
});
Product.belongsTo(Product_Inventory, {
    foreignKey: 'inventory_id'
});
Product_Discount.hasMany(Product, {
    foreignKey: 'discount_id'
});
Product.belongsTo(Product_Discount, {
    foreignKey: 'discount_id'
});

module.exports = { 
    Cart_Items,
    Customer_Address,
    Customer_Payment,
    Customer,
    Order_Details,
    Order_Items,
    Payment_Details,
    Product_Category,
    Product_Discount,
    Product_Inventory,
    Product,
    Shopping_Session
};