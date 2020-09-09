# README

API endpoints documentation:

POST /api/v1/offers

`Body`

`{
	"client_id": 1,
	"products": [
			{ "product_type_id": 2, "quantity": 26, "product_attributes": {"width": 115, "height": 23, "material": "transparent" }},
			{ "product_type_id": 1, "quantity": 7, "product_attributes": {"width": 115, "height": 23, "length": 42}}
		]
}`

`Response
{
  "status": "Offer Created"
}
`



PATCH /api/v1/offers/:id/accept

`Response
{
  "status": "Offer Accepted"
}`

PATCH /api/v1/offers/:id/reject

`Response
{
  "status": "Offer Rejected"
}`

DB schema sketch:
![Test Image 1](https://raw.githubusercontent.com/panKarol88/backend_offer_review/master/app/IMG_0539.jpeg?token=ADF7DANM46YBFOJHVFCDKZS7LDPJY)
