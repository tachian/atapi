rails g scaffold University name:string fullname:string description:text status:integer
rails g scaffold Course university:references avatar:string name:string description:text status:integer
rails g scaffold Lecture course:references name:string subtitle:string avatar:string order:integer
rails g scaffold Part lecture:references name:string teacher:string url:string duration:integer order:integer
rails g scaffold Subject name:string description:string
rails g scaffold User name:string email:string birthday:datetime gender:integer avatar:string fb_id:string fb_at:string origin:string provider:string status:
      t.string :name
      t.string :email, null: false, default: ""
      t.datetime :birthday
      t.integer :gender
      t.string :avatar
      t.string :fb_id
      t.string :fb_at
      t.string :origin
      t.string :provider
      t.string :status