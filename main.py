from langchain_google_vertexai import VertexAI

# To use model
model = VertexAI(model_name="gemini-1.5-pro-001", location="asia-east1")
message = "1+1 = ??"
output = model.invoke(message)
print(output)