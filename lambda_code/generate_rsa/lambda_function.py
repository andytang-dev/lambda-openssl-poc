import subprocess
import os

def lambda_handler(event, context):
    try:
        # Define file paths for the private and public keys
        private_key_path = "/tmp/private_key.pem"
        public_key_path = "/tmp/public_key.pem"

        # Generate the private key using openssl
        subprocess.run(
            ["openssl", "genrsa", "-out", private_key_path, "2048"],
            check=True
        )

        # Generate the public key from the private key
        subprocess.run(
            ["openssl", "rsa", "-in", private_key_path, "-pubout", "-out", public_key_path],
            check=True
        )

        # Read the generated keys
        with open(private_key_path, "r") as private_key_file:
            private_key = private_key_file.read()

        with open(public_key_path, "r") as public_key_file:
            public_key = public_key_file.read()

        # Clean up the temporary files
        os.remove(private_key_path)
        os.remove(public_key_path)

        # Return the keys
        return {
            "statusCode": 200,
            "body": {
                "private_key": private_key,
                "public_key": public_key
            }
        }

    except subprocess.CalledProcessError as e:
        return {
            "statusCode": 500,
            "body": f"Error generating keys: {str(e)}"
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": f"Unexpected error: {str(e)}"
        }