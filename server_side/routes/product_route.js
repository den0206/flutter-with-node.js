const ProductController = require('../controller/product_controller');
const passport = require('passport');

module.exports = (app) => {
  app.post(
    '/api/product/create',
    passport.authenticate('jwt', {session: false}),
    ProductController.create
  );

  app.get(
    '/api/product/findByCategoryId/:category_id',
    passport.authenticate('jwt', {session: false}),
    ProductController.findByCategoryId
  );
};
