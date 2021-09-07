class User < ApplicationRecord

    validates :name, presence: true
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :stripe_token, presence: true
    validates :subscription_plan, inclusion: { in: ["price_1JCNw2LzZFXpG8fpmRCTn3gO", "price_1JCNwILzZFXpG8fpfxwvkfvT"] }

    has_secure_password


    def save_and_subscribe
        # check if user is valid
        # check stripe token to make sure payment valid
        # if all ok, make a stripe customer
        # make that stripe customer added to plan they picked

        if self.valid?

          customer = Stripe::Customer.create(source: self.stripe_token, description: self.email)

          # make a subscription on stripe
          subscription = Stripe::Subscription.create(
              customer: customer.id, 
              items: [{ plan: self.subscription_plan}]
            ) 

            # save customer id to database
            self.stripe_customer = customer.id

            # save subscription id to the database
                self.stripe_subscription = subscription.id

            # save everything 

            self.save
        

        else
            false
        end

    rescue Stripe::CardError => e 
        @message = e.json_body[:error][:message]

        self.errors.add(:stripe_token, @message)

        false

    end


    def update_with_stripe(form_params)
        # update model with form params

        # check that its valid
        # if it is valid update stripe
        # update database
        self.assign_attributes(form_params)

        if self.valid?
            # get the subscription from stripe
            subscription = Stripe::Subscription.retrieve(self.stripe_subscription)

            # get the first item from the subscription 
            item_id = subscription.items.data[0].id
            
            # make new items list
            items = [
                { id: item_id, price: self.subscription_plan }
            ]

            # update subscription with new items

            subscription.items = items

            # save subscription to stripe

            subscription.save

            # save our data to database

            self.save

        else
            false
        end

    end

    def destroy_and_unsubscribe
        # get subscription rom stripe
        subscription = Stripe::Subscription.retrieve(self.stripe_subscription)

        # delete subscription

        subscription.delete

        # remove user completely

        self.destroy

    end

end
