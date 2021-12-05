const Product = require('../model/product');

async function create(req, res, next) {
  try {
    let product = req.body;

    const data = await Product.create(product);
    product.id = data.id;

    return res.status(201).json({
      status: true,
      message: 'プロダクトを登録しました',
      data: data.id,
    });
  } catch (e) {
    console.log(e);
    throw res
      .status(501)
      .json({status: false, message: 'Fatal Error', error: e});
  }
}

async function findByCategoryId(req, res, next) {
  try {
    const id = req.params.category_id;
    console.log('Category id', id);
    const data = await Product.findbyCategoryId(id);
    return res.status(201).json(data);
  } catch (e) {
    console.log(e);
    throw res
      .status(501)
      .json({status: false, message: 'Fatal Error', error: e});
  }
}

module.exports = {
  create,
  findByCategoryId,
};
