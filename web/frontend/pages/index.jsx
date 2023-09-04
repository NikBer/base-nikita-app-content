import {
  Card,
  Page,
  Layout,
  TextContainer,
  Image,
  Stack,
  Link,
  Text,
  Button,
} from "@shopify/polaris";
import { TitleBar } from "@shopify/app-bridge-react";
import { useTranslation, Trans } from "react-i18next";

import { trophyImage } from "../assets";

import { ProductsCard } from "../components";

export default function HomePage() {
  const { t } = useTranslation();
  const handleBlogIdFetcherJobTrigger = async () => {
    try {
        const response = await fetch('/api/trigger_blog_id_fetcher', { method: 'POST' });
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        alert('Blog ID Fetcher Job Triggered Successfully!');
    } catch (error) {
        console.error('There was a problem with the fetch operation:', error.message);
    }
};

const handleBlogPostJobTrigger = async () => {
    try {
        const response = await fetch('/api/trigger_blog_post_job', { method: 'POST' });
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        alert('Blog Post Job Triggered Successfully!');
    } catch (error) {
        console.error('There was a problem with the fetch operation:', error.message);
    }
};

const handleFetchShopifyDataWorkerTrigger = async () => {
    try {
        const response = await fetch('/api/trigger_fetch_shopify_data_worker', { method: 'POST' });
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        alert('Fetch Shopify Data Worker Triggered Successfully!');
    } catch (error) {
        console.error('There was a problem with the fetch operation:', error.message);
    }
};

  return (
    <Page narrowWidth>
      <TitleBar title={t("HomePage.title")} primaryAction={null} />
      <Layout>
        <Layout.Section>
          <Card sectioned>
            <Stack
              wrap={false}
              spacing="extraTight"
              distribution="trailing"
              alignment="center"
            >
              <Stack.Item fill>
                <TextContainer spacing="loose">
                  <Text as="h2" variant="headingMd">
                    {t("HomePage.heading")}
                  </Text>
                  <p>
                    <Trans
                      i18nKey="HomePage.yourAppIsReadyToExplore"
                      components={{
                        PolarisLink: (
                          <Link url="https://polaris.shopify.com/" external />
                        ),
                        AdminApiLink: (
                          <Link
                            url="https://shopify.dev/api/admin-graphql"
                            external
                          />
                        ),
                        AppBridgeLink: (
                          <Link
                            url="https://shopify.dev/apps/tools/app-bridge"
                            external
                          />
                        ),
                      }}
                    />
                  </p>
                  <p>{t("HomePage.startPopulatingYourApp")}</p>
                  <p>
                    <Trans
                      i18nKey="HomePage.learnMore"
                      components={{
                        ShopifyTutorialLink: (
                          <Link
                            url="https://shopify.dev/apps/getting-started/add-functionality"
                            external
                          />
                        ),
                      }}
                    />
                  </p>
                </TextContainer>
              </Stack.Item>
              <Stack.Item>
                <div style={{ padding: "0 20px" }}>
                  <Image
                    source={trophyImage}
                    alt={t("HomePage.trophyAltText")}
                    width={120}
                  />
                </div>
              </Stack.Item>
            </Stack>
          </Card>
        </Layout.Section>
        <Layout.Section>
          <ProductsCard />
        </Layout.Section>
        <Layout.Section>
  <Button onClick={handleBlogIdFetcherJobTrigger}>Trigger Blog ID Fetcher</Button>
  <Button onClick={handleBlogPostJobTrigger}>Trigger Blog Post Job</Button>
  <Button onClick={handleFetchShopifyDataWorkerTrigger}>Trigger Fetch Shopify Data Worker</Button>
</Layout.Section>

      </Layout>
    </Page>
  );
}
