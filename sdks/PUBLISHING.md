# SDK Publishing Guide

This guide explains how to publish the Nashik Darshan SDKs to npm and pub.dev.

## Prerequisites

### For TypeScript SDK (npm)

You need an npm access token from the **@caygnus organization account** (not your personal account).

#### Option 1: Use Access Token (Recommended)

1. **Log in to npmjs.com with your @caygnus organization account**

   - Visit: https://www.npmjs.com/login
   - Use your @caygnus organization credentials

2. **Create an Access Token**

   - Go to: https://www.npmjs.com/settings/caygnus/access-tokens
   - Click "Generate New Token"
   - Select "Automation" type
   - Set permissions to "Read and Publish"
   - Copy the token (starts with `npm_`)

3. **Add Token to .env File**
   ```bash
   # In project root .env file
   NPM_TOKEN=npm_your_token_here
   ```

#### Option 2: Switch npm Account

If you prefer to use `npm login`:

```bash
# Log out from current account
npm logout

# Log in with @caygnus organization account
npm login
# Enter your @caygnus organization credentials when prompted
```

**Note:** You're currently logged in as `omkar273` (personal account), but you need to be authenticated as the @caygnus organization to publish `@caygnus/nashik-darshan-sdk`.

### For Dart SDK (pub.dev)

You need pub.dev credentials for publishing.

#### Option 1: Use Credentials JSON (Recommended)

1. **Get your pub.dev credentials**

   - Visit: https://pub.dev/help/account
   - Follow instructions to get your credentials JSON

2. **Add to .env File**
   ```bash
   # In project root .env file
   PUB_CREDENTIALS='{"accessToken":"your_token_here"}'
   ```

#### Option 2: Use pub token

```bash
dart pub token add https://pub.dev
# Follow the prompts to authenticate
```

## Publishing Steps

### 1. Update Versions

```bash
# Check current version
make show-sdk-version

# Update version (reads from sdks/version.json if VERSION not provided)
make version-sdks
# Or specify version: make version-sdks VERSION=1.0.1
```

### 2. Verify SDKs

```bash
# Verify both SDKs are ready
make verify-sdks
```

### 3. Publish

#### Publish Both SDKs

```bash
make publish-sdks
```

#### Publish Individually

```bash
# TypeScript SDK only
make publish-ts-sdk

# Dart SDK only
make publish-dart-sdk
```

#### Dry Run (Test Without Publishing)

```bash
# Test TypeScript SDK publish
make publish-ts-sdk-dry-run

# Test Dart SDK publish
make publish-dart-sdk-dry-run
```

## Troubleshooting

### npm 404 Error When Publishing

If you see:

```
npm error 404 Not Found - PUT https://registry.npmjs.org/@caygnus%2fnashik-darshan-sdk
```

**Cause:** You're logged in with the wrong npm account.

**Solution:**

1. Make sure `NPM_TOKEN` in your `.env` file is from the **@caygnus organization account**
2. Or switch npm accounts: `npm logout && npm login` (use @caygnus credentials)

### Authentication Issues

**For npm:**

- Verify token is from @caygnus organization: https://www.npmjs.com/settings/caygnus/access-tokens
- Check token has "Publish" permissions
- Ensure token hasn't expired

**For pub.dev:**

- Verify credentials JSON is valid
- Check token hasn't expired
- Ensure you have publish permissions

### Package Already Exists

If you get an error that the package already exists:

- Update the version number in `sdks/version.json`
- Run `make version-sdks` to update both SDKs
- Try publishing again

## Environment Variables

Create a `.env` file in the project root:

```bash
# npm token from @caygnus organization account
NPM_TOKEN=npm_your_token_here

# pub.dev credentials JSON
PUB_CREDENTIALS='{"accessToken":"your_token_here"}'
```

**Important:**

- Never commit `.env` to git (it's in `.gitignore`)
- Use `.env.example` as a template
- Keep tokens secure and rotate them regularly

## Version Management

Versions are tracked in `sdks/version.json`. This file is committed to git and serves as the source of truth.

- Edit `sdks/version.json` to update version, then run `make version-sdks`
- Or pass version via CLI: `make version-sdks VERSION=1.0.1`
- Use `make show-sdk-version` to check current versions

## Post-Publishing

After successful publishing:

1. **Verify on npm/pub.dev**

   - npm: https://www.npmjs.com/package/@caygnus/nashik-darshan-sdk
   - pub.dev: https://pub.dev/packages/nashik_darshan_sdk

2. **Update Documentation**

   - Update installation instructions if needed
   - Update changelog/release notes

3. **Tag Release in Git**
   ```bash
   git tag -a v1.0.0 -m "Release v1.0.0"
   git push origin v1.0.0
   ```

## CI/CD Publishing

For automated publishing via GitHub Actions, see `.github/workflows/publish-sdks.yml`.

The workflow uses secrets:

- `NPM_TOKEN`: npm access token from @caygnus organization
- `PUB_CREDENTIALS`: pub.dev credentials JSON

Set these in GitHub repository settings → Secrets and variables → Actions.
