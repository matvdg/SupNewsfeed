## B3M-Newsfeed API ##

**Method:** `GET`

**Route:** `http://www.supinfo.com/3apl/api/articles/`

**Return:** list of news

    [
		{
			"id": (int),
			"author": (string),
			"createdAt": (datetime),
			"title": (string)
			"content": (string)
		},
		[...]
	]


----------
**Method:** `GET`

**Route:** `http://www.supinfo.com/3apl/api/articles/:id`

**Return:** the selected news if available (200 or 404)


   	{
   		"id": (int),
   		"author": (string),
   		"createdAt": (datetime),
   		"title": (string)
   		"content": (string)
   	}



----------
**Method:** `POST`

**Route:** `http://www.supinfo.com/3apl/api/articles/`

**Form-data:**

	author=(string)&title=(string)&content=(string)




----------


