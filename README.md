# The Network

## Keeping Track Of Contacts

- `first_name`
- `last_name`
- `email`
- `phone`
- `last_proactive_outreach`
- `last_inbound_message`
- `locations` - References different cities / countries
- `status` - This is an enum that can be `invited`, `member`, `alumni`

## Contact Notes

These are individual memos about contacts.

- `contact`
- `note`

## Locations

- `city`
- `state`

## Handling connection requests

- `to_contact` - References a contact ID
- `from_contact` - References a contact ID
- `request_context` - Opportunity for the individual to provide an overview for why