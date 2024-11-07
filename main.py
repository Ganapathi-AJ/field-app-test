import requests

# Endpoint URL
url = "https://image-analysis-vj3t6ewmoa-uc.a.run.app/analyze-image"

# Define the prompt and image path
prompt = "Analyze this image and provide a summary in bullet points."
image_path = r"./illus-1.png"  # Replace with the actual path to your image

# Prepare the request
with open(image_path, "rb") as image_file:
    # Files parameter to send the image file
    files = {"image": image_file}
    # Data parameter to send the prompt and response format as form data
    data = {
        "prompt": prompt,
        "response_format": {"type": "html"}  # Ensure response_format is an object
    }
    
    # Send the POST request
    response = requests.post(url, files=files, data=data)

# Check the response
if response.status_code == 200:
    # Print the analysis result
    print("Image Analysis Result:")
    print(response.json().get("analysis"))
else:
    # Print the error message
    print("Error:", response.status_code)
    print(response.json().get("error"))