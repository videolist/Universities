
import Spine

// Auto-generated on Wed Aug 09 2017 20:36:14 GMT-0400 (EDT)
struct RivikoAPI {


  class Users: Resource {

      // Attributes
      var roles = [String]()
      var deviceId: String?
      var deviceToken: String?
      var platform: String?
      var platformId: String?
      var platformAccessToken: String?
      var platformAccessTokenExpiresAt: NSDate?
      var name: String?
      var firstName: String?
      var lastName: String?
      var gender: String?
      var timezone: String?
      var dateOfBirth: NSDate?
      var profilePicture: String?
      var profilePictureLarge: String?
      var personalEmail: String?
      var universityEmail: String?
      var sendbirdUserId: String?
      var sendbirdAccessToken: String?
      var stripeCustomerId: String?
      var createdAt: NSDate?
      var updatedAt: NSDate?

      // Relationships
      var university: Universities?
      var organizations: LinkedResourceCollection?
      var events: LinkedResourceCollection?
      var friends: LinkedResourceCollection?

      // Foreign Keys
      var universityId: NSNumber?

      override class var resourceType: ResourceType {
          return "users"
      }

      override class var fields: [Field] {
          return fieldsFromDictionary([
              "university": ToOneRelationship(Universities.self).readOnly(),
              "organizations": ToManyRelationship(Organizations.self).readOnly(),
              "events": ToManyRelationship(Events.self).readOnly(),
              "friends": ToManyRelationship(Users.self).readOnly(),
              "roles": Attribute(),
              "deviceId": Attribute(),
              "deviceToken": Attribute(),
              "platform": Attribute(),
              "platformId": Attribute(),
              "platformAccessToken": Attribute(),
              "platformAccessTokenExpiresAt": DateAttribute(),
              "name": Attribute(),
              "firstName": Attribute(),
              "lastName": Attribute(),
              "gender": Attribute(),
              "timezone": Attribute(),
              "dateOfBirth": DateAttribute(),
              "profilePicture": Attribute(),
              "profilePictureLarge": Attribute(),
              "personalEmail": Attribute(),
              "universityEmail": Attribute(),
              "sendbirdUserId": Attribute(),
              "sendbirdAccessToken": Attribute(),
              "stripeCustomerId": Attribute(),
              "createdAt": DateAttribute(),
              "updatedAt": DateAttribute(),
              "universityId": Attribute()
          ])
      }
  }


  class Organizations: Resource {

      // Attributes
      var name: String?
      var details: String?
      var status: String?
      var isClaimed: String?
      var membershipBenefits = [String]()
      var membershipPrice: String?
      var membershipEndsAt: NSDate?
      var membershipStripeProductId: String?
      var membershipStripeSKUId: String?
      var createdAt: NSDate?
      var updatedAt: NSDate?

      // Relationships
      var organizationRepresentative: OrganizationRepresentatives?
      var university: Universities?
      var user: Users?
      var users: LinkedResourceCollection?
      var admins: LinkedResourceCollection?

      // Foreign Keys
      var userId: NSNumber?
      var universityId: NSNumber?

      override class var resourceType: ResourceType {
          return "organizations"
      }

      override class var fields: [Field] {
          return fieldsFromDictionary([
              "user": ToOneRelationship(Users.self).readOnly(),
              "university": ToOneRelationship(Universities.self).readOnly(),
              "organizationRepresentative": ToOneRelationship(OrganizationRepresentatives.self).readOnly(),
              "users": ToManyRelationship(Users.self).readOnly(),
              "admins": ToManyRelationship(Users.self).readOnly(),
              "name": Attribute(),
              "details": Attribute(),
              "status": Attribute(),
              "isClaimed": Attribute(),
              "membershipBenefits": Attribute(),
              "membershipPrice": Attribute(),
              "membershipEndsAt": DateAttribute(),
              "membershipStripeProductId": Attribute(),
              "membershipStripeSKUId": Attribute(),
              "createdAt": DateAttribute(),
              "updatedAt": DateAttribute(),
              "userId": Attribute(),
              "universityId": Attribute()
          ])
      }
  }


  class Universities: Resource {

      // Attributes
      var name: String?
      var shortName: String?
      var domains = [String]()
      var country: String?
      var currency: String?
      var city: String?
      var state: String?
      var sendbirdChannel: String?
      var usersCount: NSNumber?
      var organizationsCount: NSNumber?
      var createdAt: NSDate?
      var updatedAt: NSDate?

      // Relationships
      var users: LinkedResourceCollection?
      var organizations: LinkedResourceCollection?

      // Foreign Keys
      

      override class var resourceType: ResourceType {
          return "universities"
      }

      override class var fields: [Field] {
          return fieldsFromDictionary([
              "users": ToManyRelationship(Users.self).readOnly(),
              "organizations": ToManyRelationship(Organizations.self).readOnly(),
              "name": Attribute(),
              "shortName": Attribute(),
              "domains": Attribute(),
              "country": Attribute(),
              "currency": Attribute(),
              "city": Attribute(),
              "state": Attribute(),
              "sendbirdChannel": Attribute(),
              "usersCount": Attribute(),
              "organizationsCount": Attribute(),
              "createdAt": DateAttribute(),
              "updatedAt": DateAttribute()
          ])
      }
  }


  class Events: Resource {

      // Attributes
      var name: String?
      var details: String?
      var startAt: NSDate?
      var location: String?
      var ticketStripeProductId: String?
      var ticketStripeSKUId: String?
      var ticketPrice: String?
      var ticketQuantity: NSNumber?
      var ticketMembershipRequired: String?
      var placeName: String?
      var placeStreet: String?
      var placeCity: String?
      var placeZip: String?
      var placeCountry: String?
      var placeLatitude: String?
      var placeLongitude: String?
      var images = [String]()
      var createdAt: NSDate?
      var updatedAt: NSDate?
      var deletedAt: NSDate?

      // Relationships
      var organization: Organizations?
      var university: Universities?
      var users: LinkedResourceCollection?
      var channels: LinkedResourceCollection?

      // Foreign Keys
      var universityId: NSNumber?
      var organizationId: NSNumber?

      override class var resourceType: ResourceType {
          return "events"
      }

      override class var fields: [Field] {
          return fieldsFromDictionary([
              "university": ToOneRelationship(Universities.self).readOnly(),
              "organization": ToOneRelationship(Organizations.self).readOnly(),
              "users": ToManyRelationship(Users.self).readOnly(),
              "channels": ToManyRelationship(Channels.self).readOnly(),
              "name": Attribute(),
              "details": Attribute(),
              "startAt": DateAttribute(),
              "location": Attribute(),
              "ticketStripeProductId": Attribute(),
              "ticketStripeSKUId": Attribute(),
              "ticketPrice": Attribute(),
              "ticketQuantity": Attribute(),
              "ticketMembershipRequired": Attribute(),
              "placeName": Attribute(),
              "placeStreet": Attribute(),
              "placeCity": Attribute(),
              "placeZip": Attribute(),
              "placeCountry": Attribute(),
              "placeLatitude": Attribute(),
              "placeLongitude": Attribute(),
              "images": Attribute(),
              "createdAt": DateAttribute(),
              "updatedAt": DateAttribute(),
              "deletedAt": DateAttribute(),
              "universityId": Attribute(),
              "organizationId": Attribute()
          ])
      }
  }


  class EventsUsers: Resource {

      // Attributes
      var status: String?
      var hiddenAt: NSDate?
      var createdAt: NSDate?
      var updatedAt: NSDate?

      // Relationships
      var ticket: Tickets?
      var user: Users?
      var event: Events?

      // Foreign Keys
      var userId: NSNumber?
      var eventId: NSNumber?
      var ticketId: NSNumber?

      override class var resourceType: ResourceType {
          return "eventsUsers"
      }

      override class var fields: [Field] {
          return fieldsFromDictionary([
              "event": ToOneRelationship(Events.self).readOnly(),
              "user": ToOneRelationship(Users.self).readOnly(),
              "ticket": ToOneRelationship(Tickets.self).readOnly(),
              "status": Attribute(),
              "hiddenAt": DateAttribute(),
              "createdAt": DateAttribute(),
              "updatedAt": DateAttribute(),
              "userId": Attribute(),
              "eventId": Attribute(),
              "ticketId": Attribute()
          ])
      }
  }


  class OrganizationsUsers: Resource {

      // Attributes
      var roles = [String]()
      var status: String?
      var log: String?
      var createdAt: NSDate?
      var updatedAt: NSDate?
      var deletedAt: NSDate?

      // Relationships
      var organization: Organizations?
      var user: Users?
      var membership: Memberships?

      // Foreign Keys
      var userId: NSNumber?
      var organizationId: NSNumber?
      var membershipId: NSNumber?

      override class var resourceType: ResourceType {
          return "organizationsUsers"
      }

      override class var fields: [Field] {
          return fieldsFromDictionary([
              "membership": ToOneRelationship(Memberships.self).readOnly(),
              "user": ToOneRelationship(Users.self).readOnly(),
              "organization": ToOneRelationship(Organizations.self).readOnly(),
              "roles": Attribute(),
              "status": Attribute(),
              "log": Attribute(),
              "createdAt": DateAttribute(),
              "updatedAt": DateAttribute(),
              "deletedAt": DateAttribute(),
              "userId": Attribute(),
              "organizationId": Attribute(),
              "membershipId": Attribute()
          ])
      }
  }


  class Channels: Resource {

      // Attributes
      var sendbirdChannel: String?
      var createdAt: NSDate?
      var updatedAt: NSDate?

      // Relationships
      var event: Events?
      var user: Users?
      var users: LinkedResourceCollection?

      // Foreign Keys
      var eventId: NSNumber?
      var userId: NSNumber?

      override class var resourceType: ResourceType {
          return "channels"
      }

      override class var fields: [Field] {
          return fieldsFromDictionary([
              "user": ToOneRelationship(Users.self).readOnly(),
              "event": ToOneRelationship(Events.self).readOnly(),
              "users": ToManyRelationship(Users.self).readOnly(),
              "sendbirdChannel": Attribute(),
              "createdAt": DateAttribute(),
              "updatedAt": DateAttribute(),
              "eventId": Attribute(),
              "userId": Attribute()
          ])
      }
  }


  class ChannelsUsers: Resource {

      // Attributes
      var createdAt: NSDate?
      var updatedAt: NSDate?

      // Relationships
      var channel: Channels?
      var user: Users?

      // Foreign Keys
      var channelId: NSNumber?
      var userId: NSNumber?

      override class var resourceType: ResourceType {
          return "channelsUsers"
      }

      override class var fields: [Field] {
          return fieldsFromDictionary([
              "user": ToOneRelationship(Users.self).readOnly(),
              "channel": ToOneRelationship(Channels.self).readOnly(),
              "createdAt": DateAttribute(),
              "updatedAt": DateAttribute(),
              "channelId": Attribute(),
              "userId": Attribute()
          ])
      }
  }


  class Friendships: Resource {

      // Attributes
      var createdAt: NSDate?
      var updatedAt: NSDate?
      var friendId: NSNumber?

      // Relationships
      

      // Foreign Keys
      

      override class var resourceType: ResourceType {
          return "friendships"
      }

      override class var fields: [Field] {
          return fieldsFromDictionary([
              "createdAt": DateAttribute(),
              "updatedAt": DateAttribute(),
              "friendId": Attribute()
          ])
      }
  }


  class PushNotifications: Resource {

      // Attributes
      var name: String?
      var status: String?
      var message: String?
      var badge: NSNumber?
      var sound: String?
      var log: String?
      var sentAt: NSDate?
      var createdAt: NSDate?
      var updatedAt: NSDate?

      // Relationships
      var user: Users?

      // Foreign Keys
      var userId: NSNumber?

      override class var resourceType: ResourceType {
          return "pushNotifications"
      }

      override class var fields: [Field] {
          return fieldsFromDictionary([
              "user": ToOneRelationship(Users.self).readOnly(),
              "name": Attribute(),
              "status": Attribute(),
              "message": Attribute(),
              "badge": Attribute(),
              "sound": Attribute(),
              "log": Attribute(),
              "sentAt": DateAttribute(),
              "createdAt": DateAttribute(),
              "updatedAt": DateAttribute(),
              "userId": Attribute()
          ])
      }
  }


  class Memberships: Resource {

      // Attributes
      var startsAt: NSDate?
      var endsAt: NSDate?
      var isActive: String?
      var createdAt: NSDate?
      var updatedAt: NSDate?

      // Relationships
      var orderItem: OrderItems?
      var order: Orders?
      var organization: Organizations?
      var user: Users?

      // Foreign Keys
      var userId: NSNumber?
      var organizationId: NSNumber?
      var orderId: NSNumber?
      var orderItemId: NSNumber?

      override class var resourceType: ResourceType {
          return "memberships"
      }

      override class var fields: [Field] {
          return fieldsFromDictionary([
              "user": ToOneRelationship(Users.self).readOnly(),
              "organization": ToOneRelationship(Organizations.self).readOnly(),
              "order": ToOneRelationship(Orders.self).readOnly(),
              "orderItem": ToOneRelationship(OrderItems.self).readOnly(),
              "startsAt": DateAttribute(),
              "endsAt": DateAttribute(),
              "isActive": Attribute(),
              "createdAt": DateAttribute(),
              "updatedAt": DateAttribute(),
              "userId": Attribute(),
              "organizationId": Attribute(),
              "orderId": Attribute(),
              "orderItemId": Attribute()
          ])
      }
  }


  class Tickets: Resource {

      // Attributes
      var createdAt: NSDate?
      var updatedAt: NSDate?

      // Relationships
      var orderItem: OrderItems?
      var order: Orders?
      var event: Events?
      var user: Users?

      // Foreign Keys
      var userId: NSNumber?
      var eventId: NSNumber?
      var orderId: NSNumber?
      var orderItemId: NSNumber?

      override class var resourceType: ResourceType {
          return "tickets"
      }

      override class var fields: [Field] {
          return fieldsFromDictionary([
              "user": ToOneRelationship(Users.self).readOnly(),
              "event": ToOneRelationship(Events.self).readOnly(),
              "order": ToOneRelationship(Orders.self).readOnly(),
              "orderItem": ToOneRelationship(OrderItems.self).readOnly(),
              "createdAt": DateAttribute(),
              "updatedAt": DateAttribute(),
              "userId": Attribute(),
              "eventId": Attribute(),
              "orderId": Attribute(),
              "orderItemId": Attribute()
          ])
      }
  }


  class OrganizationRepresentatives: Resource {

      // Attributes
      var firstName: String?
      var lastName: String?
      var dateOfBirth: NSDate?
      var addressLine1: String?
      var addressLine2: String?
      var addressCity: String?
      var addressState: String?
      var addressPostalCode: String?
      var legalEntityName: String?
      var stripeAccountId: String?
      var createdAt: NSDate?
      var updatedAt: NSDate?
      var deletedAt: NSDate?

      // Relationships
      var user: Users?
      var organization: Organizations?

      // Foreign Keys
      var organizationId: NSNumber?
      var userId: NSNumber?

      override class var resourceType: ResourceType {
          return "organizationRepresentatives"
      }

      override class var fields: [Field] {
          return fieldsFromDictionary([
              "organization": ToOneRelationship(Organizations.self).readOnly(),
              "user": ToOneRelationship(Users.self).readOnly(),
              "firstName": Attribute(),
              "lastName": Attribute(),
              "dateOfBirth": DateAttribute(),
              "addressLine1": Attribute(),
              "addressLine2": Attribute(),
              "addressCity": Attribute(),
              "addressState": Attribute(),
              "addressPostalCode": Attribute(),
              "legalEntityName": Attribute(),
              "stripeAccountId": Attribute(),
              "createdAt": DateAttribute(),
              "updatedAt": DateAttribute(),
              "deletedAt": DateAttribute(),
              "organizationId": Attribute(),
              "userId": Attribute()
          ])
      }
  }


  class Orders: Resource {

      // Attributes
      var amountGross: String?
      var amountNet: String?
      var stripeOrderId: String?
      var stripeChargeId: String?
      var status: String?
      var createdAt: NSDate?
      var updatedAt: NSDate?
      var deletedAt: NSDate?

      // Relationships
      var user: Users?
      var items: LinkedResourceCollection?

      // Foreign Keys
      var userId: NSNumber?

      override class var resourceType: ResourceType {
          return "orders"
      }

      override class var fields: [Field] {
          return fieldsFromDictionary([
              "user": ToOneRelationship(Users.self).readOnly(),
              "items": ToManyRelationship(OrderItems.self).readOnly(),
              "amountGross": Attribute(),
              "amountNet": Attribute(),
              "stripeOrderId": Attribute(),
              "stripeChargeId": Attribute(),
              "status": Attribute(),
              "createdAt": DateAttribute(),
              "updatedAt": DateAttribute(),
              "deletedAt": DateAttribute(),
              "userId": Attribute()
          ])
      }
  }


  class OrderItems: Resource {

      // Attributes
      var sku: String?
      var currency: String?
      var amountGross: String?
      var amountNet: String?
      var name: String?
      var quantity: NSNumber?
      var createdAt: NSDate?
      var updatedAt: NSDate?

      // Relationships
      var order: Orders?

      // Foreign Keys
      var orderId: NSNumber?

      override class var resourceType: ResourceType {
          return "orderItems"
      }

      override class var fields: [Field] {
          return fieldsFromDictionary([
              "order": ToOneRelationship(Orders.self).readOnly(),
              "sku": Attribute(),
              "currency": Attribute(),
              "amountGross": Attribute(),
              "amountNet": Attribute(),
              "name": Attribute(),
              "quantity": Attribute(),
              "createdAt": DateAttribute(),
              "updatedAt": DateAttribute(),
              "orderId": Attribute()
          ])
      }
  }


}
