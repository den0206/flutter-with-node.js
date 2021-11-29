const {func} = require('../config/config');
const User = require('../model/user');
const jwt = require('jsonwebtoken');
const dotEnv = require('dotenv');
const Rol = require('../model/role');
const {use} = require('passport');

async function getAll(req, res, next) {
  try {
    const data = await User.getAll();
    console.log(data);
    return res.status(201).json(data);
  } catch (e) {
    console.log(e);
    throw res.status(501).json({success: false, message: 'Fatal Error'});
  }
}

async function findByID(req, res, next) {
  try {
    const id = req.params.id;
    console.log(id);
    const data = await User.findbyId(id);
    return res.status(201).json(data);
  } catch (e) {
    console.log(e);
    throw res.status(501).json({success: false, message: 'Fatal Error'});
  }
}

async function register(req, res, next) {
  try {
    const user = req.body;
    console.log(user);
    const data = await User.create(user);
    /// client
    await Rol.create(data.id, '1');

    return res.status(201).json({
      status: true,
      message: 'ユーザーを登録しました',
      data: data.id,
    });
  } catch (e) {
    console.log(e);
    throw res
      .status(501)
      .json({status: false, message: 'Fatal Error', error: e});
  }
}

async function login(req, res, next) {
  try {
    const email = req.body.email;
    const password = req.body.password;
    const myuser = await User.findbyEmail(email);

    if (!myuser)
      return res.status(401).json({status: false, message: 'Not find user'});
    dotEnv.config();

    if (!User.isPasswordMatched(password, myuser.password)) {
      return res.status(401).json({
        status: false,
        message: 'Password not match',
      });
    }

    const token = jwt.sign(
      {id: myuser.id, email: myuser.email},
      process.env.SECRET
    );

    const data = {
      ...myuser,
      session_token: token,
    };

    await User.updateToken(myuser.id, token);

    return res.status(201).json({
      status: true,
      message: 'Get Token',
      data: data,
    });
  } catch (e) {
    console.log(e);
    return res.status(501).json({
      status: false,
      message: 'Fatal Error',
      error: e,
    });
  }
}

async function logout(req, res, next) {
  try {
    const id = req.body.id;
    await User.updateToken(id, null);
    return res.status(201).json({
      status: true,
      message: 'Log out',
    });
  } catch (e) {
    console.log(e);
    return res.status(501).json({
      status: false,
      message: 'Fatal Error',
      error: e,
    });
  }
}

async function update(req, res, next) {
  try {
    const user = req.body;
    await User.update(user);

    return res.status(201).json({
      status: true,
      message: 'アップデート',
      // data: data.id,
    });
  } catch (e) {
    console.log(e);
    return res.status(501).json({
      status: false,
      message: 'Fatal Error',
      error: e,
    });
  }
}

module.exports = {
  getAll,
  register,
  findByID,
  login,
  logout,
  update,
};
