PUT /library
{
	"settings": {
	"index.number_of_shards":1,
	"index.number_of_replicas":0
	}
}
# By default if didnt set the setting it will create 5 primary # shards and 1 replica

POST /library/books/_bulk
{"index": { "_id": 1}}
{"title": "Harry potter", "price":250, "Author": "J K Rowling", "colors": ["red","green","blue"], "description": "Outward appearance. Throughout the series, Harry is described as having his father's perpetually untidy black hair, his mother's bright green eyes, and a lightning bolt-shaped scar on his forehead. ... Rowling has also stated that Harry inherited his parents good looks."}
{	"index": { "_id":2}}
{	"title": "Half Girlfriend", "price":350, "Author": "Chethan Bagath", "colors": ["red","white","blue"],"description": "Chetan Bhagat commented,'Half-Girlfriend, to me, is a unique Indian phenomenon, where boys and girls are not clear about their relationship status with each other. A boy may think he is more than friends with the girl, but the girl is still not his girlfriend.... Because, in India, that is what most men get.'"}
{	"index": { "_id":3}}
{	"title": "Balyakala sakhi", "price":250, "Author": "Basheer",	"colors": ["orange","green","blue"],"description":"Balyakalasakhi (Malayalam:Balyakalasakhi,meaning childhood companion), is a Malayalam romantic tragedy novel written by Vaikom Muhammad Basheer. ...By Basheer's own admission, the story is largely autobiographical."}
{	"index": { "_id":4}}
{	"title": "The Alchemist", "price":150, "Author": "Paulo Cohelo", "colors": ["red","black"],"description":"Santiago meets an Englishman who wants to learn the secret of alchemy, or turning any metal into gold, from a famous alchemist who lives at an oasis on the way to the pyramids. While traveling, Santiago begins listening to the desert and discovering the Soul of the World. ... It is the alchemist"}






GET /library/books/_search
{
	"query": {
	"match":{
	"title": "The Alchemist"
	}
	}
}

GET /library/books/_search
{
	"query": {
	"match_phrase":{
	"description": "The Alchemist"
	}
	}
}

GET /library/books/_search
{
	"query": {
	  "bool": {
	    "must": [
	      {"match": {
	        "title": "The Alchemist"
	      }}
	    ]
  , "must_not": [
    {"match_phrase": {
      "description": "abc"
    }}
  ]
	  }
}
}
#must act as and there is "should" that act as or

#multimatch	
GET /library/books/_search
{
  "query": {
    "multi_match": {
      "query":4,
      "fields": ["_id","description"]
    }
  }
}

#highlight the matching text 
GET /library/books/_search
{
  "query": {
    "multi_match": {
      "query":"The Alchemist",
      "fields": ["_id","title"]
    }
  },
  "highlight": {
    "fields": {
      "title": {}
    }
  }


  GET /library/_analyze
{
  "tokenizer": "standard",
  "filter": ["uppercase","unique"]
  , "text": "SAN san san acd" 
  
}

# letter tockenizer matches letters
GET /library/_analyze
{
  "tokenizer": "letter",
  "filter": ["lowercase","unique"]
  , "text": "SAN san san acd 123 abc@cde.com, www.google.com" 
  
}

#uax_url_email matches emails and urls
GET /library/_analyze
{
  "tokenizer": "uax_url_email",
  "filter": ["lowercase","unique"]
  , "text": "SAN san san acd 123 abc@cde.com, www.google.com" 
  
}


#get the most popular colr in the document
GET /library/_search
{ "size":2, 
  "aggs": {
    "popular-colors": {
      "terms": {
        "field": "colors.keyword"
      
      }
    }
  }
}


GET /library/_search
{ "size":0, 
  "aggs": {
    "popular-colors": {
      "terms": {
        "field": "colors.keyword"
      
      }
    },
    "average":{
      "stats": {
        "field": "price"
      }
    }
  }
  
  }


  #updating data

  #to re-index

GET /library/books/1
{
"title": "Harry potter", "price":250, "Author": "J K Rowling", "colors": ["red","green","blue"], "description": "Outward appearance. Throughout the series, Harry is described as having his father's perpetually untidy black hair, his mother's bright green eyes, and a lightning bolt-shaped scar on his forehead. ... Rowling has also stated that Harry inherited his parents good looks."
}

#to update
GET /library/books/1/_update
{
  "doc":
  {
    "colors":["viloet"]
  }
}


#to get field types

GET /library/_mapping

#creating new record
#settings for new record 

PUT /emp_details
{
	"settings": {
	"index": {
	"number_of_shards": 2,
	"number_of_replicas": 1,
	"analysis": {
	"analyzer": {
	"my-desc-analyzer": {
	"type": "custom",
	"tokenizer": "uax_url_email",
	"filters": ["lowercase"]
	}
   }
  }
 }
},
"mappings": {
	"employee": {
	"properties": {
	"name": {
	"type": "text"
	},
	"favorite-colors": {
	"type": "keyword"
	},
	"birth-date": {
	"type": "date",
	"format": "year_month_day"
	},
	"company_name":{
	"type": "text"
	},
	"current_location": {
	"type": "geo_point"
	},
	"description":{
	"type": "text",
	"analyzer": "my-desc-analyzer"
	}
	}
	}
}
}
#input for new record

POST /emp_details/employee/_bulk
{ "index": { "_id":1}}
{ "name": "Harry potter", "birth-date": "2000-01-01", "favorite-color": ["red","green","blue"], "current_location": { "lat": 32.349722, "lon": -87.641111}, "description": "Movie Outward appearance. Throughout the series, Harry is described as having his father's perpetually untidy black hair, his mother's bright green eyes, and a lightning bolt-shaped scar on his forehead. ... www.gmail.com or abcd.mail@gmail.com once Rowling has also stated that Harry inherited his parents good looks.","company_name":"pramati"}
{ "index": { "_id":2}}
{ "name": "Half Girlfriend","birth-date": "2000-01-05" ,"favorite-color": ["red","white","blue"],"current_location": { "lat": 33.349722, "lon": -86.641111}, "description": "Movie Chetan Bhagat commented,'Half-Girlfriend, to me, is a unique Indian phenomenon, where boys and girls are not clear about their relationship status with each other. Once A boy may think he is more than friends with the girl, but the girl is still not his girlfriend.... Because, in India, that is what most men get.'","company_name":"google"}







#ranges

{
 "query": {
 "bool": {
 "must": [
 {
 "match": {
 "description":"is"
 
 }
 }
 ],
 "filter": {
 "range": {
 "price": {
 "gte": 150
 }
 }
 }
 }
 }
 }



