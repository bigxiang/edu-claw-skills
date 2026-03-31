# Curriculum Authentication 🔑

The Curriculum Developer Platform uses JWT (JSON Web Tokens) for authentication. Every request to the API must include a valid access token in the `Authorization` header.

## Login Endpoints

The primary endpoint for authentication is:
`POST /api/v1/auth/login`

### Authentication Flow

1. **Submit Credentials**: Send your account email and password to the login endpoint.
2. **Receive Token**: Upon successful login, the API returns an `access_token` and `refresh_token`.
3. **Use Access Token**: For every subsequent API call, include the token in the `Authorization` header as a Bearer token.
4. **Refresh (Optional)**: If the access token expires, use the refresh token to obtain a new one via `POST /api/v1/auth/refresh`.

---

## Direct Login Example

```bash
# Login request with user credentials
LOGIN_RESPONSE=$(curl -s -X POST https://edu-staging.njyaoduo.com/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@example.com",
    "password": "Yd123456"
  }')

# Save access token from response
CURRICULUM_ACCESS_TOKEN=$(echo "$LOGIN_RESPONSE" | jq -r '.access_token')

if [ "$CURRICULUM_ACCESS_TOKEN" = "null" ]; then
  echo "❌ Login failed: $(echo "$LOGIN_RESPONSE" | jq -r '.detail')"
  exit 1
fi

echo "✅ Login successful! Token: ${CURRICULUM_ACCESS_TOKEN:0:10}..."
```

### Request Structure
```json
{
  "email": "your_email@example.com",
  "password": "your_password"
}
```

### Response Structure
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer",
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

---

## Token Usage

Once you have the token, include it in your requests like this:

```bash
curl -X GET https://edu-staging.njyaoduo.com/api/v1/auth/me \
  -H "Authorization: Bearer $CURRICULUM_ACCESS_TOKEN"
```

---

## Profile and Organization

You can retrieve your current user profile and see which organization you are in.

```bash
# Get your own user profile
curl -X GET https://edu-staging.njyaoduo.com/api/v1/auth/me \
  -H "Authorization: Bearer $CURRICULUM_ACCESS_TOKEN"

# List your organization memberships
curl -X GET https://edu-staging.njyaoduo.com/api/v1/auth/organizations \
  -H "Authorization: Bearer $CURRICULUM_ACCESS_TOKEN"
```

---

## Security Best Practices

- **Never Log Tokens**: Avoid printing full tokens to terminal logs or insecure storage.
- **Set Token Expiry**: Access tokens are short-lived for security.
- **Use Secure Storage**: In AI agents, store tokens in memory or encrypted local storage.
- **Rotate Passwords**: Change your password if you suspect your account is compromised.
- **RLS Context**: Your token contains your `user_id` and `organization_id`, which the database uses for Row Level Security.
