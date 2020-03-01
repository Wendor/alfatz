# Installing

# API Requests
* [GET] /api/RoleVariant
```json
[
  {
    "Id": 1,
    "Name": "Аналитик",
  },
  ...
]
```
* [GET] /api/roles
```json
[1,3,...]
```
* [PUT] /api/roles
```json
[2,3,...]
```
* [GET] /api/ProductTopVariant
```json
[
  {
    "Id": 1,
    "Name": "Популярные"
  },
  ...
]
```
* [GET] /api/ProductTops/:id
```json
[
  {
    "Id": 2,
    "Name": "Товар 1",
    "Cost": 255.0000,
    "Buys": 6
  },
  ...
]
```