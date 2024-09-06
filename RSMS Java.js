use RealEstateSystem

//---------Drop Collections----
db.Owner.drop()
db.Property.drop()
db.Client.drop()
db.Agent.drop()
db.RentalInfo.drop()
db.Sell.drop()


//--------Creating Collections----
db.createCollection("Owner");
db.createCollection("Property");
db.createCollection("Client");
db.createCollection("Agent");
db.createCollection("RentalInfo");
db.createCollection("Sell");



// ----------Inserting Document Into Collections-----------

// Inserting Into Owner Collection----


db.Owner.insertMany([
  {
    owner_id: 1,
    owner_name: "Ramesh Thakur",
    owner_address: [
      { state: "Bagmati", district: "Kirtipur", municipality: "kathmandu", ward_no: "08" },
      { state: "Bagmati", district: "Kathmandu", municipality: "Kathmandu", ward_no: "09" }
    ],
    phone_number: "9845891234",
    email: "rameshth@gmail.com"
  },
  {
    owner_id: 2,
    owner_name: "Rudra Dhungana",
    owner_address: [
      { state: "Bagmati", district: "kathmandu", municipality: "Kageshowrir", ward_no: "03" },
     { state: "Bagmati", district: "Kirtipur", municipality: "kathmandu", ward_no: "07" }
    ],
    phone_number: "98453366441",
    email: "rudradhungana@gmail.com"
  },
   {
    owner_id: 3,
    owner_name: "Rudra Thapa",
    owner_address: [
      { state: "Bagmati", district: "lalitpur", municipality: "godawari", ward_no: "07" },
     { state: "Bagmati", district: "lalitpur", municipality: "mahalaxmi", ward_no: "04" }
    ],
    phone_number: "9845398451",
    email: "thaparudra@gmail.com"
  },
   {
    owner_id: 4,
    owner_name: "Soniya Magar",
    owner_address: [
      { state: "Bagmati", district: "chitwan", municipality: "bharatpur", ward_no: "19" },
     { state: "Bagmati", district: "lalitpur", municipality: "mahalaxmi", ward_no: "04" }
    ],
    phone_number: "9789145261",
    email: "soniyamagar15@gmail.com"
  },
   {
    owner_id: 5,
    owner_name: "Soni Magar",
    owner_address: [
      { state: "Bagmati", district: "bhaktapur", municipality: "Suryabinayak", ward_no: "08" },
    { state: "Bagmati", district: "bhaktapur", municipality: "Suryabinayak", ward_no: "07" },
    ],
    phone_number: "9789145278",
    email: "sonimagar15@gmail.com"
  },
   {
    owner_id: 6,
    owner_name: "Sonita Marasini",
    owner_address: [
      { state: "Bagmati", district: "Dhading", municipality: "Galchi", ward_no: "07" },
    { state: "Bagmati", district: "Kathmandu", municipality: "Kageshowi", ward_no: "09" },
    ],
    phone_number: "9789149978",
    email: "sonita85@gmail.com"
  }
]);

db.Owner.find();

//----------------Inserting Into Agent Collection----

db.Agent.insertMany([
  {
   agent_id: 1,
    agent_name: "Samantha Lama",
    agent_address: [
      { state: "Bagmati", district: "Sindupalchowk", municipality: "Sangagadi", ward_no: "13" },
      { state: "Bagmati", district: "Kathmandu", municipality: "Katmandu", ward_no: "03" }
    ],
    phone_number: "9845658912",
    email: "samantha.lama@example.com",
    property_sold: "Null"
  },
  {
    agent_id: 2,
    agent_name: "Sanjog Bhandari",
    agent_address: [
      { state: "Gandaki", district: "Kaski", municipality: "Pokhara", ward_no: "19" },
      { state: "Bagmati", district: "Bhaktapur", municipality: "Suryabinayak", ward_no: "07" }
    ],
    phone_number: "9850356214",
    email: "sanjogbhandari98@gmail.com",
    property_sold: "1002"
  },
  {
    agent_id: 3,
    agent_name: "Sangita ghimire",
    agent_address: [
      { state: "Gandaki", district: "Kaski", municipality: "Pokhara", ward_no: "19" },
      { state: "Bagmati", district: "Bhaktapur", municipality: "Suryabinayak", ward_no: "05" }
    ],
    phone_number: "9850359654",
    email: "sangeetame@gmail.com",
    property_sold: 1004
    
  },
  {
    agent_id: 4,
    agent_name: "Sannani ghimire",
    agent_address: [
      { state: "Bagmati", district: "Sindupalchowk", municipality: "Barhabise", ward_no: "02" },
       { state: "Bagmati", district: "lalitpur", municipality: "mahalaxmi", ward_no: "03" }
    ],
    phone_number: "98685520156",
    email: "sannani1986@gmail.com",
    property_sold: 1005
  }
]);

db.Agent.find();


//----------Inserting Into Property Collection---

db.Property.insertMany([
{
    property_id: 1001,
    property_type: "Residential",
    property_address: [ { state: "Gandaki", district: "Tanahu", municipality: "Tanahu", ward_no: "21" }],
    property_size: "2000 sqft",
    property_price: "15000000",
    property_status: "Available",
    property_description: "A luxurious apartment with a view of Central Park",
    property_category: "Apartment",
    owner_id:1,
    bedrooms: 3,
    bathrooms: 2,
    pool: "Yes",
    yard: "No"  
},
{
    property_id:1002,
    property_type: "Residential",
    property_address: [ { state: "Bagmati", district: "Kathmandu", municipality: "Kathmandu", ward_no: "07" }],
    property_size: "1800 sqft",
    property_price: 1500000,
    property_status: "Available",
    property_description: "A luxurious apartment with a view River and park",
    property_category: "Apartment",
    owner_id: 2,
    bedrooms: 3,
    bathrooms: 2,
    pool: "Yes",
    yard: "Yes"  
},
    {
    
    property_id: 1003,
    property_type: "Commercial",
    property_address: [ { state: "Bagmati", district: "Kathmandu", municipality: "Kageshowri", ward_no: "17" }],
    property_size: "1000 sqft",
    property_price: 150000,
    property_status: "Available",
    property_description: "Peaceful work environment",
    property_category: "Office",
    owner_id: 4,
    bedrooms: "Null",
    bathrooms: 2,
    pool: "No",
    yard: "No"  
    
}    ,
{
    
    property_id: 1004,
    property_type: "Commercial",
    property_address: [ { state: "Bagmati", district: "Bhaktapur", municipality: "Suryabinayak", ward_no: "14" }],
    property_size: "800 sqft",
    property_price: 128000,
    property_status: "Available",
    property_description: "Parking space available",
    property_category: "Office",
    owner_id: 3,
    bedrooms: "Null",
    bathrooms: 2,
    pool: "No",
    yard: "No"  
},
{
    
    property_id: 1005,
    property_type: "Commercial",
    property_address: [ { state: "Bagmati", district: "Bhaktapur", municipality: "Suryabinayak", ward_no: "14" }],
    property_size: "800 sqft",
    property_price: 128000,
    property_status: "Available",
    property_description: "Parking space available",
    property_category: "Office",
    owner_id:5,
    bedrooms: "Null",
    bathrooms: 2,
    pool: "No",
    yard: "No"    
},
{
    
    property_id: 1006,
    property_type: "Residential",
    property_address: [ { state: "Gandaki", district: "Kaski", municipality: "Pokhara", ward_no: "19" }],
    property_size: "1350 sqft",
    property_price: 13000000,
    property_status: "Available",
    property_description: "A luxurious apartment with gym",
    property_category: "Apartment",
    owner_id: 3,
    bedrooms: 3,
    bathrooms: 22,
    pool: "Yes",
    yard: "No"  
}
,
{
    
    property_id: 1007,
    property_type: "Residential",
    property_address: [ { state: "Bagmati", district: "Lalitpur", municipality: "Godawari", ward_no: "19" }],
    property_size: "1400 sqft",
    property_price: 13900000,
    property_status: "Sold",
    property_description: "A luxurious apartment with gym",
    property_category: "Apartment",
    owner_id: 4,
    bedrooms: 3,
    bathrooms: 22,
    pool: "Yes",
    yard: "No"  
},
{
    property_id:1008,
    property_type: "Residential",
    property_address: [ { state: "Bagmati", district: "Kathmandu", municipality: "Kathmandu", ward_no: "07" }],
    property_size: "1355 sqft",
    property_price: 2410000,
    property_status: "Sold",
    property_description: "A luxurious apartment with a view River and park",
    property_category: "Apartment",
    owner_id: 3,
    bedrooms: 3,
    bathrooms: 2,
    pool: "Yes",
    yard: "Yes"  
}
  
]);

db.Property.find();

//----------------Inserting Into Client Collection-------

db.Client.insertMany([
  {
    client_id: 101,
    client_name: "Ram Babu Thakur",
    client_address: [
      { state: "Bagmati", district: "Kathmandu", municipality: "Kirtipur", ward_no: "08" },
      { state: "Bagmati", district: "Kathmandu", municipality: "Kathmandu", ward_no: "09" }
    ],
    phone_number: "9802361400",
    email: "baburam@gmail.com"
  },
  {
    client_id: 102,
    client_name: "Kushma Dhungana",
    client_address: [
      { state: "Koshi", district: "Dharan", municipality: "Dharan", ward_no: "05" },
      { state: "Bagmati", district: "Kathmandu", municipality: "Kathmandu", ward_no: "07" }
    ],
    phone_number: "9898563211",
    email: "kushmadhungana67@gmail.com"
  },
   
   {
    client_id: 103,
    client_name: "Anil Acharya",
    client_address: [
      { state: "Bagmati", district: "Chitwan", municipality: "Manakamana", ward_no: "23" },
      { state: "Bagmati", district: "lalitpur", municipality: "mahalaxmi", ward_no: "03" }
    ],
    phone_number: "9789632481",
    email: "acharyaanil2@gmail.com"
  },
  {
   client_id: 104,
    client_name: "Ananta Yadav",
    client_address: [
      { state: "Bagmati", district: "Chiwan", municipality: "Ratna Nagar", ward_no: "20" },
      { state: "Bagmati", district: "Bhaktapur", municipality: "Thimi", ward_no: "09" }
    ],
    phone_number: "9845215658",
    email: "yadavananta183@gmail.com"
  }
]);

db.Client.find();


//-------------Inserting Into Sell Collection ---------

db.Sell.insertMany([
   {
      sell_id: 1,
      price:120000,
      sell_date: new ISODate('2023-02-15T10:30:00Z'),
      client_id: 101,
      property_id: 1005,
      agent_id: 4
   },
   {
      sell_id: 2,
      price: 1280000,
      sell_date: new ISODate('2023-01-28T10:30:00Z'),
      client_id: 102,
      property_id: 1004,
      agent_id: 3
   },
   {
      sell_id: 3,
      price: 120000,
      sell_date: new ISODate('2023-02-18T10:30:00Z'),
      client_id: 102,
      property_id: 1002,
      agent_id: 2
   },
   {
      sell_id: 4,
      price: 13900000,
      sell_date: new ISODate('2023-01-19T10:30:00Z'),
      client_id: 103,
      property_id: 1007,
      agent_id: 2
   },
   {
      sell_id: 5,
      price: 2410000,
      sell_date: new ISODate('2023-03-15T10:30:00Z'),
      client_id: 104,
      property_id: 1008,
      agent_id: 3
   }
]);


db.Sell.find();

//--------------Inserting Into RentInfo Collection------

db.RentalInfo.insertMany([
   {
      rent_id: 1,
      price: 1700000,
      start_date: ISODate("2023-03-15T10:30:00Z"),
      end_date: ISODate("2024-03-16T10:30:00Z"),
      property_id: 1002,
      client_id: 103,
      renting_agent_id: 1
   },
   {
      rent_id: 2,
      price: 1500000,
      start_date: ISODate("2023-03-15T10:30:00Z"),
      end_date: ISODate("2024-10-16T10:30:00Z"),
      property_id:1001,
      client_id: 104,
      renting_agent_id: 1
   },
   {
      rent_id: 3,
      price: 130000,
      start_date: ISODate("2023-03-15T10:30:00Z"),
      end_date: ISODate("2024-10-16T10:30:00Z"),
      property_id: 1003,
      client_id: 104,
      renting_agent_id: 2
   }
]);

db.RentalInfo.find();


//-----------Join------

db.Property.aggregate([
  {
    $lookup: {
      from: "Sell",
      localField: "property_id",
      foreignField: "property_id",
      as: "sell_info"
    }
  },
  {
    $unwind: "$sell_info"
  },
  {
    $lookup: {
      from: "Client",
      localField: "sell_info.client_id",
      foreignField: "client_id",
      as: "client_info"
    }
  },
  {
    $unwind: "$client_info"
  },
  {
    $lookup: {
      from: "Owner",
      localField: "owner_id",
      foreignField: "owner_id",
      as: "owner_info"
    }
  },
  {
    $unwind: "$owner_info"
  },
  {
    $lookup: {
      from: "Agent",
      localField: "sell_info.agent_id",
      foreignField: "agent_id",
      as: "agent_info"
    }
  },
  {
    $unwind: "$agent_info"
  },
  {
    $match: {
      "agent_info.agent_name": "Sangita ghimire"
    }
  },
  {
    $project: {
      "property_id": 1,
      "property_category": 1,
      "price": 1,
      "sell_date": "$sell_info.sell_date",
      "client_name": "$client_info.client_name",
      "owner_name": "$owner_info.owner_name",
      "agent_name": "$agent_info.agent_name"
    }
  }
]);


//------------Union Operator-----
db.Owner.aggregate([
  { $project: { address: "$owner_address" } },
  { $unwind: "$address" },
  { $group: { _id: "$address" } },
  { $project: { _id: 0, state: "$_id.state", district: "$_id.district", municipality: "$_id.municipality", ward_no: "$_id.ward_no" } },
  { $sort: { state: 1, district: 1, municipality: 1, ward_no: 1 } },
  { $unionWith: { coll: "Agent", pipeline: [
    { $project: { address: "$agent_address" } },
    { $unwind: "$address" },
    { $group: { _id: "$address" } },
    { $project: { _id: 0, state: "$_id.state", district: "$_id.district", municipality: "$_id.municipality", ward_no: "$_id.ward_no" } }
  ] } }
]);



//----------Nested----
db.Owner.aggregate([
  {
    $lookup: {
      from: "Property",
      localField: "owner_id",
      foreignField: "owner_id",
      as: "property"
    }
  },
  {
    $match: {
      "property.property_category": "Apartment",
      
    } },
  {
    $project: {
      _id: 0,
      owner_name: "$owner_name",
      email: "$email",
      phone_number: "$phone_number",
      state: "$owner_address.state",
      municipality: "$owner_address.municipality",
      ward_no: "$owner_address.ward_no"
    }
  }
]);


//-----------------------Timestamp----------

db.Sell.aggregate([
    {
        $project: {
            sell_id: "$sell_id",
          sell_date: "$sell_date",
            days: {
                $dateDiff: {
                    startDate: "$sell_date",
                    endDate: ISODate(),
                    unit: 'day',
                },
            },
        }
    },
    { $match: { days: { $lt: 50 } } }
]);


//-----------------Partition----------

db.Sell.aggregate([
  {
    $match: {
      sell_date: {
        $gte: new ISODate('2023-01-01T00:00:00Z'),
        $lt: new ISODate('2023-03-25T00:00:00Z')
      }
    }
  },
  {
    $match: {
      agent_id: 3
    }
  },
  {
    $group: {
      _id: null,
      total_sales: { $sum: "$price" },
      avg_price: { $avg: "$price" },
      max_price: { $max: "$price" }
    }
  }
]);
