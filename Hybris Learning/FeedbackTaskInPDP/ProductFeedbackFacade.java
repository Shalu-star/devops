/**
 *
 */
package org.training.facades.feedback;

/**
 * @author labommid
 *
 */



import de.hybris.platform.commercefacades.product.ProductFacade;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.product.ProductService;
import de.hybris.platform.servicelayer.dto.converter.Converter;
import de.hybris.platform.servicelayer.exceptions.UnknownIdentifierException;

import org.springframework.beans.factory.annotation.Required;
import org.springframework.util.Assert;
import org.training.core.service.FeedbackService;




public class ProductFeedbackFacade
{
    ProductService productService;
	 private FeedbackService feedbackService;



	 ProductFacade productFacade;



	 private Converter<ProductModel, ProductData> productConverter;




	 @Required
	 public void setProductConverter(final Converter<ProductModel, ProductData> productConverter)
	 {
		 this.productConverter = productConverter;
	 }



	 //    public Converter<ProductModel, ProductData> getProductFeedbacksConverter() {
	 //        return productFeedbacksConverter;
	 //    }
	 //
	 //    public void setProductFeedbacksConverter(Converter<ProductModel, ProductData> productFeedbacksConverter) {
	 //        this.productFeedbacksConverter = productFeedbacksConverter;
	 //    }
	 //    private Converter<ProductModel, ProductData> productFeedbacksConverter ;
	 protected ProductService getProductService()
	 {
		 return productService;
	 }



	 public void setProductService(final ProductService productService)
	 {
		 this.productService = productService;
	 }



	 protected FeedbackService getFeedbackService()
	 {
		 return feedbackService;
	 }



	 public void setFeedbackService(final FeedbackService feedbackService)
	 {
		 this.feedbackService = feedbackService;
	 }




	 public ProductData postProductFeedback(final String productCode, final String feeds)
			 throws UnknownIdentifierException, IllegalArgumentException
	 {
		 Assert.notNull(productCode, "Parameter reviewData cannot be null.");
		 final ProductModel pm = getFeedbackService().createFeedback(productCode, feeds);
		 final ProductData pd = productConverter.convert(pm);
		 /* final ProductData pd = getProductConverter().convert(pm); */
		 return pd;



	 }




}

