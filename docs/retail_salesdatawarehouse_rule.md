silver layer before loading data into customer\_info



Tasks:



Duplicate customer\_id check



customer\_id NULL check



Customer name ke extra spaces remove karna



First/last name standardize karna



Email ko lowercase karna



Phone number format standardize karna



Gender values standardize karna



Date of birth validate karna



Future DOB identify karna



Invalid/missing values handle karna





silver layer before loading data into product\_info



Tasks:



Duplicate product\_id check



product\_id NULL check



Product name clean karna



Category/subcategory standardize karna



Brand names standardize karna



Cost ko numeric/decimal format mein convert karna



Negative cost check karna



Product price/cost validation



Missing category identify karna



Extra spaces remove karna





silver layer before loading data into sales\_info



Tasks:



Duplicate order\_id / sales\_id check



NULL customer\_id check



NULL product\_id check



NULL store\_id check



Invalid dates check



Quantity validation



Quantity <= 0 check



Price validation



Negative sales amount check



Customer/Product/Store IDs ka master tables ke saath validation



Sales amount calculate karna



Date format standardize karna





silver layer before loading data into stores\_info



Tasks:



Duplicate store\_id check



store\_id NULL check



Store name clean karna



City/state/country standardize karna



Address trim karna



Phone number standardize karna



Store opening date validate karna



Invalid/missing location data identify karna







### GOLD LAYER FACT\_SALES



calculate:



&#x20;   gross\_amount



&#x20;   discount\_amount



&#x20;   net\_sales



&#x20;   cost\_amount



&#x20;   profit



##### FORMULA:



gross\_amount = quantity × unit\_price



discount\_amount = gross\_amount × discount\_percent / 100



net\_sales = gross\_amount - discount\_amount



cost\_amount = quantity × cost\_price



profit = net\_sales - cost\_amount

