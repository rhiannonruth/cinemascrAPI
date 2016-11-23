# cinemascrAPI

### As of November 1st 2016 this is no longer working as google/movies has been discontinued.

> An API that screenscrapes google.com/movies and returns cinemas and film listings based on a postcode search.

[![Build Status](https://travis-ci.org/rhiannonruth/cinemascrAPI.svg?branch=master)](https://travis-ci.org/rhiannonruth/cinemascrAPI)
[![Coverage Status](https://coveralls.io/repos/github/rhiannonruth/cinemascrAPI/badge.svg?branch=master)](https://coveralls.io/github/rhiannonruth/cinemascrAPI?branch=master)
[![Code Climate](https://codeclimate.com/github/rhiannonruth/cinemascrAPI/badges/gpa.svg)](https://codeclimate.com/github/rhiannonruth/cinemascrAPI)
<!-- [![Dependency Status](https://gemnasium.com/badges/github.com/rhiannonruth/cinemascrAPI.svg)](https://gemnasium.com/github.com/rhiannonruth/cinemascrAPI) -->

### Technology
Simple [Ruby on Rails](http://rubyonrails.org/) application, using [Mechanize](https://github.com/sparklemotion/mechanize) and [Nokogiri](http://www.nokogiri.org/) for screen grabbing and HTML parsing. Tested with [RSpec](http://rspec.info/).

### Installation

- Clone the repo and install dependencies with ```bundle```
- Run with ```rails s``` and visit ``http://localhost:3000/``

### Usage
API call for today's film showings for cinemas based on a postcode search. It will return JSON and there is no authentication.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Request**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;GET ``/api/v1/cinemas/search?postcode=:postcode``

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Response**
```json
 {
"cinemas": [
  {
  "name": "Greenwich Picturehouse",
  "address": "180 Greenwich High Road, London, United Kingdom",
  "telephone": "0871 902 5732",
    "movies": [
    {
      "title": "The Girl on the Train",
      "length": "1hr 52min",
      "rating": "15",
      "showtimes": [
        "13:20",
        "15:50",
        "18:20",
        "20:50"
        ]
      },
    {
      "title": "Bridget Jones's Baby",
      "length": "2hr 2min",
      "rating": "15",
      "showtimes": [
        "12:30",
        "15:15",
        "18:00"
        ]
      },
    {
      "title": "Miss Peregrine's Home for Peculiar Children",
      "length": "2hr 6min",
      "rating": "12A",
      "showtimes": [
        "13:45",
        "15:00",
        "17:30"
        ]
      }
    ]
  }
]
}
```

### Note
This is work in progress. We hope to have the option to also return IMDB ratings and potentially other searches.

### Authors
- [Rhiannon Lolley Neville](https://github.com/rhiannonruth)
- [Paul Rees](https://github.com/paulalexrees)
- [Kevin McCarthy](https://github.com/kevinpmcc)
