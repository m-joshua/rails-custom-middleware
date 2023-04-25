# README

>

**To create an authorization for a certain route or action**

> 1. Create a policy class
>    - Your policy class should follow these convention ControllerNamePolicy (singular controller name)
>    - The policy method should be "method_name?" (method name same as the controller method)
>      ex: to authorize a method from PostsController#edit you must create a policy named PostPolicy with edit? method on app/policies
> directory
> 2. Your authorization logic will be placed on the method created on the policy
> 3. @user instance variable will be containing the current_user and @record instance variable will contain the params


**To create an authorizatin for activeadmin actions**

> 1. Create a policy class
>    - Your policy class should follow these convention Admin::ControllerNamePolicy (singular controller name)
>    - The policy method should be "method_name?" (method name same as the controller method)
>      ex: to authorize a method from admin/posts/:id/edit you must create a policy named Admin::PostPolicy with edit? method on
> app/policies/admin directory
> 2. Your authorization logic will be placed on the method created on the policy
> 3. @user instance variable will be containing the current_admin_user and @record instance variable will contain the params

**To create an authorization for graphql mutations and queries**
> 1. you have to define a method on GraphqlPolicy that is named after the graphql operation name
> 2. Operation name are the name defined after the graphql command. ex. the query: query getPosts will have an operation name of get_posts
> 3. In order to authorize that getPosts query, you have to defined get_posts? method at GraphqlPolicy class
> 4. @user instance variable will be containing the current_user and @record instance variable will contain the params


    query getPosts {
	    getPosts {
		    id
		    userId
		    title
		    content
	    }
    }


    mutation createPost($input: CreatePostInput!) {
		    createPost(input: $input) {
			    post {
				    id
				    title
				    content
			    }
		    }
	    }

	    variables:
	    {
		    "input": {
		    "userId": 2,
		    "title": "post 4",
		    "content": "test post 4"
	    }
    }


