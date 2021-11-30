const ProductController = require('../controller/product_controller');
const passport = require('passport');

module.exports = (app) => {
  app.post(
    '/api/product/create',
    passport.authenticate('jwt', {session: false}),
    ProductController.create
  );
};
