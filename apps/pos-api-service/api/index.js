const { NestFactory } = require('@nestjs/core');
const { AppModule } = require('../dist/app.module');
const { GlobalExceptionFilter } = require('../dist/common/filters/http-exception.filter');
const { ResponseInterceptor } = require('../dist/common/interceptors/response.interceptor');
const { DocumentBuilder, SwaggerModule } = require('@nestjs/swagger');

let app;

async function getApp() {
  if (!app) {
    app = await NestFactory.create(AppModule);
    app.setGlobalPrefix('api');
    app.useGlobalFilters(new GlobalExceptionFilter());
    app.useGlobalInterceptors(new ResponseInterceptor());
    app.enableCors({
      origin: '*',
      methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH'],
      allowedHeaders: [
        'Content-Type',
        'Authorization',
        'x-user-type',
        'x-branch-id',
        'x-company-id',
      ],
    });

    const config = new DocumentBuilder()
      .setTitle('Ryzera POS — Auth & User Management API')
      .setDescription('Ryzera POS Backend API deployed on Vercel')
      .setVersion('1.0.0')
      .addBearerAuth(
        {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
          description: 'Enter JWT token from /auth/login',
          in: 'header',
        },
        'JWT-auth',
      )
      .build();

    const document = SwaggerModule.createDocument(app, config);
    SwaggerModule.setup('api/docs', app, document, {
      swaggerOptions: {
        persistAuthorization: true,
      },
    });

    await app.init();
  }
  return app.getHttpAdapter().getInstance();
}

module.exports = async (req, res) => {
  const instance = await getApp();
  instance(req, res);
};
