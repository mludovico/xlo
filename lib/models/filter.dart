enum OrderBy {DATE, PRICE}

const VENDOR_TYPE_PARTICULAR = 1 << 0;
const VENDOR_TYPE_PROFESSIONAL = 1 << 1;

class Filter{
  String search;
  OrderBy orderBy;
  int minPrice, maxPrice, vendorType;

  Filter({this.search, this.orderBy = OrderBy.DATE, this.minPrice, this.maxPrice,
    this.vendorType = VENDOR_TYPE_PARTICULAR | VENDOR_TYPE_PROFESSIONAL
  });

}