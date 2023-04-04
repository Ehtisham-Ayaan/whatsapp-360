import { useState } from "react";
import {
  Card,
  Heading,
  TextContainer,
  DisplayText,
  TextStyle,
  TextField
} from "@shopify/polaris";

import { useAppQuery, useAuthenticatedFetch } from "../hooks";
import Swal from 'sweetalert2'

export function GetWhatsAppInfo () {
  const fetch = useAuthenticatedFetch()
  const [phoneNumber, setPhoneNumber] = useState('');
  const [msgLine, setmsgLine] = useState('');
  const [isLoading, setIsLoading] = useState(false);


  const handlePhoneNumberChange = (event) => {
    setPhoneNumber(event);
  }

  const handleMsgLine = (event) => {
    setmsgLine(event);
  }

  const isValidPhoneNumber = (phoneNumber) => {
    const phoneRegex = /^\+(?:[0-9] ?){6,14}[0-9]$/;
    return phoneRegex.test(phoneNumber);
  };

  const updateTheme = async () => {
    if (isValidPhoneNumber(phoneNumber)) {
      setIsLoading(true);
      const response = await fetch("/api/themes/update_theme", {
        method: 'PUT',
        body: JSON.stringify({
          msg_line: msgLine,
          phone_number: phoneNumber
        })
      });
      if (response.ok) {
        setIsLoading(false);
        Swal.fire({
          text: 'Whatsapp Integrated Successfuly!',
          icon: 'success',
          confirmButtonText: 'Okay'
        })
      } else {
        Swal.fire({
          title: 'Error!',
          text: 'Something went wrong, please try again later!',
          icon: 'error',
          confirmButtonText: 'Okay'
        })
      }
    } else {
      Swal.fire({
        title: 'Error!',
        text: 'Please Use International way of adding phone number!',
        icon: 'error',
        confirmButtonText: 'Okay'
      })
    }
  }

  return (
    <>
      <Card
        title="General Settings"
        sectioned
        primaryFooterAction={{
          content: "Save",
          onAction: updateTheme,
          loading: isLoading,
        }}
      >
        <TextContainer spacing="loose">
          <Heading element="h4">
            <DisplayText size="medium">
              <TextStyle variation="strong">
                <TextField
                  label="Whatsapp Number"
                  placeholder="+12124567890"
                  value={phoneNumber}
                  onChange={handlePhoneNumberChange}
                  autoComplete="off"
                />
              </TextStyle>
            </DisplayText>
          </Heading>
        </TextContainer>
        <TextContainer className="mt-tight">
          <Heading element="h4">
            <DisplayText size="medium">
              <TextStyle variation="strong">
                <TextField
                  className="mt-tight"
                  label="Whatsapp Message"
                  placeholder="Hi, I came to your store and I want to make an inquiry."
                  value={msgLine}
                  onChange={handleMsgLine}
                  autoComplete="off"
                />
              </TextStyle>
            </DisplayText>
          </Heading>
        </TextContainer>
      </Card>
    </>
  );
}
