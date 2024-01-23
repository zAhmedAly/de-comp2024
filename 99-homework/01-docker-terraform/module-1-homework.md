# Module 1 Homework

# Docker & SQL

## Question 1. Knowing docker tags

    docker run --help

>   `ANSWER: --rm                Automatically remove the container when it exits` 

## Question 2. Understanding docker first run

    docker run -it --entrypoint=bash python:3.9

    root@b168eb1ddc76:/# pip list

    Package    Version
    ---------- -------
    pip        23.0.1
    setuptools 58.1.0
    wheel      0.42.0

    What is version of the package wheel ?

>   `ANSWER: wheel      0.42.0` 

## Prepare Postgres

## Question 3. Count records

How many taxi trips were totally made on September 18th 2019?

Tip: started and finished on 2019-09-18.

    SELECT COUNT(*) FROM green_taxi_trips 
    WHERE DATE_PART('DAY', lpep_pickup_datetime) = '18'
    AND   DATE_PART('DAY', lpep_dropoff_datetime) = '18'

>   `ANSWER: Count is 15612` 
    

## Question 4. Largest trip for each day

Which was the pick up day with the largest trip distance Use the pick up time for your calculations.

    SELECT DISTINCT DATE(lpep_pickup_datetime) , MAX(trip_distance)
    FROM green_taxi_trips
    GROUP BY DATE(lpep_pickup_datetime) 
    ORDER BY 2 DESC

>   `ANSWER: 2019-09-26	MAX DISTANCE 341.64` 
    

## Question 5. Three biggest pick up Boroughs

Consider lpep_pickup_datetime in '2019-09-18' and ignoring Borough has Unknown
Which were the 3 pick up Boroughs that had a sum of total_amount superior to 50000?

    SELECT DISTINCT zn."Borough", SUM(gtt.total_amount) AS sum_total_amount
    FROM zones zn , green_taxi_trips gtt
    WHERE gtt."PULocationID" = zn."LocationID"
    AND	  zn."Borough" <> 'Unknown'
    GROUP BY zn."Borough"
    HAVING 	 SUM(gtt.total_amount)  > 50000
    ORDER BY 2 DESC

>   `ANSWER:	"Brooklyn" "Manhattan" "Queens"` 
    
    "Brooklyn"	2,619,378.5399998147
    "Queens"	2,460,386.1700001983
    "Manhattan"	2,427,880.920000594

## Question 6. Largest tip

    For the passengers picked up in September 2019 in the zone name Astoria which was the drop off zone that had the largest tip? We want the name of the zone, not the id.

        SELECT ZN."Zone" 
        FROM TAXI_ZONE_LOOKUP ZN JOIN 
        (SELECT GTT."DOLocationID" DOL, MAX(GTT.tip_amount) AS MTA
        FROM GREEN_TAXI_TRIPS GTT, TAXI_ZONE_LOOKUP PUZN 
        WHERE PUZN."Zone" = 'Astoria'
        AND   PUZN."LocationID" = GTT."PULocationID"
        GROUP BY GTT."DOLocationID"
        ORDER BY 2 DESC
        LIMIT 1) SUBQ
        ON SUBQ.DOL = ZN."LocationID" ;

>   `ANSWER:	JFK Airport` 
    

# Terraform

## Question 7. Creating Resources

    $ ./terraform apply

    Terraform used the selected providers to generate the following execution plan.     
    Resource actions are indicated with the following symbols:
    + create

    Terraform will perform the following actions:

    # google_bigquery_dataset.demo-dataset will be created
    + resource "google_bigquery_dataset" "demo-dataset" {
        + creation_time              = (known after apply)
        + dataset_id                 = "terra_dataset"
        + default_collation          = (known after apply)
        + delete_contents_on_destroy = false
        + effective_labels           = (known after apply)
        + etag                       = (known after apply)
        + id                         = (known after apply)
        + is_case_insensitive        = (known after apply)
        + last_modified_time         = (known after apply)
        + location                   = "US"
        + max_time_travel_hours      = (known after apply)
        + project                    = "dtc-de-course-01152024"
        + self_link                  = (known after apply)
        + storage_billing_model      = (known after apply)
        + terraform_labels           = (known after apply)
        }

    # google_storage_bucket.demo-bucket will be created
    + resource "google_storage_bucket" "demo-bucket" {
        + effective_labels            = (known after apply)
        + force_destroy               = true
        + id                          = (known after apply)
        + location                    = "US"
        + name                        = "dtc-de-course-01152024-terra-bucket"
        + project                     = (known after apply)
        + public_access_prevention    = (known after apply)
        + rpo                         = (known after apply)
        + self_link                   = (known after apply)
        + storage_class               = "STANDARD"
        + terraform_labels            = (known after apply)
        + uniform_bucket_level_access = (known after apply)
        + url                         = (known after apply)

        + lifecycle_rule {
            + action {
                + type = "AbortIncompleteMultipartUpload"
                }
            + condition {
                + age                   = 1
                + matches_prefix        = []
                + matches_storage_class = []
                + matches_suffix        = []
                + with_state            = (known after apply)
                }
            }
        }

    Plan: 2 to add, 0 to change, 0 to destroy.

    Do you want to perform these actions?
    Terraform will perform the actions described above.
    Only 'yes' will be accepted to approve.

    Enter a value: yes

  
>   `google_bigquery_dataset.demo-dataset: Creating...` 

>   `google_storage_bucket.demo-bucket: Creating...` 

>   `google_bigquery_dataset.demo-dataset: Creation complete after 1s [id=projects/dtc-de-course-01152024/datasets/terra_dataset]` 

>   `google_storage_bucket.demo-bucket: Creation complete after 2s [id=dtc-de-course-01152024-terra-bucket]` 

>   `Apply complete! Resources: 2 added, 0 changed, 0 destroyed.` 
    
    
    
    

    


