package io.webapp.framework.config.json.jackson.serializer;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import io.webapp.framework.util.DateUtil;

import java.io.IOException;
import java.util.Date;

public class JacksonDateSerializer extends JsonSerializer<Date> {
    @Override
    public void serialize(Date date, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException, JsonProcessingException {
        String string = null;
        if (date != null) {
            string = DateUtil.getDateTimeString(date);
        }

        jsonGenerator.writeString(string);
    }
}
