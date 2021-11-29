const UserController = require('../controller/user_controller');
const passport = require('passport');

module.exports = (app) => {
  app.get('/api/users/getAll', UserController.getAll);
  app.get(
    '/api/users/findById/:id',
    passport.authenticate('jwt', {session: false}),
    UserController.findByID
  );

  app.post('/api/users/create', UserController.register);
  app.post('/api/users/login', UserController.login);
  app.post('/api/users/logout', UserController.logout);
  app.put(
    '/api/users/update',
    passport.authenticate('jwt', {session: false}),
    UserController.update
  );
};
