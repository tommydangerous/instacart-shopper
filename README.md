Shopper Challenge
=================

Please build this like you would an actual project you're working on. It should be production-ready code that you're proud of.

Instacart Shoppers are the face of the company - literally - and as such, we require them to go through a rigorous process before they can deliver your groceries. This includes a comprehensive application as well as a training process.

This challenge is broken into two parts. The first part is implementing the public-facing site that a prospective Instacart Shopper would see when hearing about the opportunities that Instacart offers. The second is writing analytics to monitor the progress of shoppers through the hiring funnel.

## Part 1: Shopper Applicants

Instead of tracking prospective Instacart Shoppers through a third-party service, we want to build the application in-house.

The process is simple:

1. Applicant sees a landing page and be presented with a button to "Apply Now"
2. Applicant presented with a form asking some basic information.
3. On a separate page, the applicant is required to confirm they are OK with Instacart running a background check.
4. They submit the form and presented with a confirmation.

### Requirements

We are looking primarily for a good "product sense." This means thinking about the problem from the Instacart Shopper applicant's perspective and crafting a nice experience. The best submissions include the following:

- Validation messages shown clearly.
- Landing page has a clear call to action.
- Shopper Applicant is persisted in the database.
- No need for authentication or authorization, however, create a session using the Applicant's email so they can view/edit their current application.
- A clean look & feel of the pages - we want Shoppers to feel welcome.

## Part 2: Applicant Analysis

To monitor how well applicants are being moved through the hiring process, we want to build a simple funnel that tracks how many applicants are in each step of the process by week. We'll use this data to look for places to improve our Personal Shopper screening process.

### Requirements

Write the `/funnels.json` endpoint such that it takes two parameters as options, `start_date` and `end_date`, and returns a JSON response analyzing the `workflow_state`s of the Applicants, grouped by the week they applied.   

This should be structured like:

```json
{
    "2014-12-01-2014-12-07": {
        "applied": 100,
        "quiz_started": 50,
        "quiz_completed": 20,
        "onboarding_requested": 10,
        "onboarding_completed": 5,
        "hired": 1,
        "rejected": 0
    },
    "2014-12-08-2014-12-14": {
        "applied": 200,
        "quiz_started": 75,
        "quiz_completed": 50,
        "onboarding_requested": 20,
        "onboarding_completed": 10,
        "hired": 5,
        "rejected": 0
    },
    "2014-12-15-2014-12-21": {
        "applied": 70,
        "quiz_started": 20,
        "quiz_completed": 10,
        "onboarding_requested": 0,
        "onboarding_completed": 0,
        "hired": 0,
        "rejected": 0
    },
    "2014-12-22-2014-12-28": {
        "applied": 40,
        "quiz_started": 20,
        "quiz_completed": 15,
        "onboarding_requested": 5,
        "onboarding_completed": 1,
        "hired": 1,
        "rejected": 0
    }
}
```

- This result is simulated in terms of the numbers but correctly shows how the response should be formatted.
- The buckets (e.g. "2014-12-22-2014-12-28") can be ordered however you prefer - we are simply looking for accuracy.
- The buckets should cover Monday to Sunday.
- Buckets need not include states which have a count of 0.
- `start_date` and `end_date` will be formatted like '2014-12-22'.
- We will only be testing date ranges up to (and including) 2014-12-31, so any applicants you create (assuming your system clock is accurate to a year) will not be included.

We're particular interested in the speed of your implementation, so please consider performance as you work through this part of the challenge.
