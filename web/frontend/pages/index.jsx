import {
  Page,
  Layout,
} from "@shopify/polaris";
import { TitleBar } from "@shopify/app-bridge-react";
import { GetWhatsAppInfo } from "../components/WhatsAppInfo";

export default function HomePage() {
  return (
    <Page fullWidth>
      <TitleBar title="Whatsapp 360" primaryAction={null} />
      <Layout>
        <Layout.Section>
          <GetWhatsAppInfo />
        </Layout.Section>
      </Layout>
    </Page>
  );
}
