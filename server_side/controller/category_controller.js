const Category = require('../model/category');

async function getAll(req, res, next) {
  try {
    const data = await Category.getAll();

    res.status(201).json(data);
  } catch (e) {
    console.log(e);
    throw res
      .status(501)
      .json({status: false, message: 'Fatal Error', error: e});
  }
}

async function create(req, res, next) {
  try {
    const category = req.body;

    const data = await Category.create(category);

    return res.status(201).json({
      status: true,
      message: 'カテゴリーを登録しました',
      data: data.id,
    });
  } catch (e) {
    console.log(e);
    throw res
      .status(501)
      .json({status: false, message: 'Fatal Error', error: e});
  }
}

module.exports = {
  getAll,
  create,
};
