# Describe your resource type here
# Keep "c" as the name to indicate that this resource and its attributes are compliant


resource "google_container_analysis_note" "c" {
    name = "testtime-c"

    expiration_time = "2026-04-26T23:59:59Z"

    attestation_authority {
        hint{
            human_readable_name = "Build Attestaion Authority"
        }
    }

}
