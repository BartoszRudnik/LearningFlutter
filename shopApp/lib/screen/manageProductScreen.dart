import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/model/product.dart';
import 'package:shopApp/provider/productsProvider.dart';

class ManageProductScreen extends StatefulWidget {
  static const routeName = 'manage-product';

  @override
  _ManageProductScreenState createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  final _priceFocuseNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  final _imageUrlController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var _product = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  var _isLoading = false;
  var _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void dispose() {
    _priceFocuseNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUlr);
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUlr);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _product = Provider.of<ProductsProvider>(context, listen: false).findById(productId);

        _initValues = {
          'title': _product.title,
          'description': _product.description,
          'price': _product.price.toStringAsFixed(2),
          'imageUrl': '',
        };

        _imageUrlController.text = _product.imageUrl;
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUlr() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    _formKey.currentState.validate();

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      if (_product.id == null) {
        Provider.of<ProductsProvider>(context, listen: false).addProduct(_product).then(
          (value) {
            setState(() {
              _isLoading = false;
            });
            Navigator.of(context).pop();
          },
        );
      } else {
        Provider.of<ProductsProvider>(context, listen: false).updateProduct(_product).then(
          (value) {
            _isLoading = false;
            Navigator.of(context).pop();
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
        title: Text('Manage Product Data'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a title';
                        } else {
                          return null;
                        }
                      },
                      initialValue: _initValues['title'],
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocuseNode);
                      },
                      onSaved: (value) {
                        _product = Product(
                          id: _product.id,
                          title: value,
                          description: _product.description,
                          price: _product.price,
                          imageUrl: _product.imageUrl,
                          isFavorite: _product.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      validator: (value) {
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.tryParse(value) < 0) {
                          return 'Price must be greater or equal to zero';
                        }
                        if (value.isEmpty) {
                          return 'Please enter a price';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Price',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocuseNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) {
                        _product = Product(
                          description: _product.description,
                          id: _product.id,
                          imageUrl: _product.imageUrl,
                          price: double.parse(value),
                          title: _product.title,
                          isFavorite: _product.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description';
                        }

                        return null;
                      },
                      focusNode: _descriptionFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      onSaved: (value) {
                        _product = Product(
                          description: value,
                          id: _product.id,
                          imageUrl: _product.imageUrl,
                          price: _product.price,
                          title: _product.title,
                          isFavorite: _product.isFavorite,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.blueGrey),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a url')
                              : FittedBox(
                                  child: Image.network(
                                    this._imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an image url';
                              }
                              if (!value.startsWith('http') && !value.startsWith('https')) {
                                return 'Please enter an valid url';
                              }
                              if (!value.endsWith('jpg') && !value.endsWith('png') && !value.endsWith('jpeg')) {
                                return 'Wrong image type';
                              }

                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Image url'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onEditingComplete: () {
                              setState(() {});
                            },
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              _product = Product(
                                description: _product.description,
                                id: _product.id,
                                imageUrl: value,
                                price: _product.price,
                                title: _product.title,
                                isFavorite: _product.isFavorite,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
