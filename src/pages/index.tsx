import React from 'react';
import Head from 'next/head';

export default function Home() {
  return (
    <>
      <Head>
        <title>NinjaLinking</title>
        <meta name="description" content="NinjaLinking SAAS Platform" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main className="min-h-screen bg-gray-50">
        <div className="container mx-auto px-4 py-8">
          <h1 className="text-4xl font-bold text-center text-gray-900 mb-8">
            Welcome to NinjaLinking
          </h1>
          <p className="text-lg text-center text-gray-600">
            Your SAAS platform is ready to go!
          </p>
        </div>
      </main>
    </>
  );
}