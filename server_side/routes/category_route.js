const CategoryController = require('../controller/category_controller');
const passport = require('passport');

module.exports = (app) => {
  app.get(
    '/api/category/getAll',
    passport.authenticate('jwt', {session: false}),
    CategoryController.getAll
  );
  app.post(
    '/api/category/create',
    passport.authenticate('jwt', {session: false}),
    CategoryController.create
  );
};
