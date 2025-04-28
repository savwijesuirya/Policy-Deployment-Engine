# Describe your resource type here
# Keep "nc" as the name to indicate that this resource and its attributes are non-compliant


resource "google_container_analysis_note" "nc" {
    name = "testtime-nc"

    expiration_time = ""  #set as invalid cuz it is nc

    attestation_authority {
        hint{
            human_readable_name = "Build Attestaion Authority"
        }
    }

}
