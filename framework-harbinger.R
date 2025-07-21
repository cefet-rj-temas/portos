# Harbinger Package
# version 1.1.707



#loading Harbinger
library(daltoolbox)
library(harbinger)

nome_portos <- c('Vitória', 'São Francisco do Sul', 'Paranaguá', 'Imbituba', 'Aratu', 'Porto Velho', 'Pelotas', 'Itajaí')
print(nome_portos[1])



# establishing han_autoencoder method aae
model <- han_autoencoder(3, 2, aae_encode_decode, num_epochs = 1500)
# fitting the model
model <- fit(model, atracacao_semanal[['Itajaí']]$total_tempo_espera)
# making detections
detection <- detect(model, atracacao_semanal[['Itajaí']]$total_tempo_espera)
# filtering detected events
print(detection |> dplyr::filter(event==TRUE))
# evaluating the detections
evaluation <- evaluate(model, detection$event, atracacao_semanal[['Itajaí']]$event)
print(evaluation$confMatrix)
# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)


# establishing han_autoencoder method cae
cae <- function(x) {
  model <- han_autoencoder(3, 2, cae_encode_decode, num_epochs = 1500)
  # fitting the model
  model <- fit(model, atracacao_semanal[[x]]$total_tempo_espera)
  # making detections
  detection <- detect(model, atracacao_semanal[[x]]$total_tempo_espera)
  # filtering detected events
  print(detection |> dplyr::filter(event==TRUE))
  # evaluating the detections
  evaluation <- evaluate(model, detection$event, atracacao_semanal[[x]]$event)
  print(evaluation$confMatrix)
}

cae('Itajaí')

# ploting the results
grf <- har_plot(model, atracacao_semanal[[x]]$total_tempo_espera, detection, atracacao_semanal[[x]]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)


# establishing han_autoencoder method dns
dns <- function(x) {
  model <- han_autoencoder(3, 2, dns_encode_decode, num_epochs = 1500)
  # fitting the model
  model <- fit(model, atracacao_semanal[[x]]$total_tempo_espera)
  # making detections
  detection <- detect(model, atracacao_semanal[[x]]$total_tempo_espera)
  # filtering detected events
  print(detection |> dplyr::filter(event==TRUE))
  # evaluating the detections
  evaluation <- evaluate(model, detection$event, atracacao_semanal[[x]]$event)
  print(evaluation$confMatrix)
}

dns('Itajaí')

# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)


# establishing han_autoencoder method lstm
lstm <- function(x) {
  model <- han_autoencoder(3, 2, lae_encode_decode, num_epochs = 1500)
  # fitting the model
  model <- fit(model, atracacao_semanal[[x]]$total_tempo_espera)
  # making detections
  detection <- detect(model, atracacao_semanal[[x]]$total_tempo_espera)
  # filtering detected events
  print(detection |> dplyr::filter(event==TRUE))
  # evaluating the detections
  evaluation <- evaluate(model, detection$event, atracacao_semanal[[x]]$event)
  print(evaluation$confMatrix)
}

lstm('Itajaí')

# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)


sae <- function(x) {
  # establishing han_autoencoder method sae
  model <- han_autoencoder(3, 2, sae_encode_decode, num_epochs = 1500)
  # fitting the model
  model <- fit(model, atracacao_semanal[[x]]$total_tempo_espera)
  # making detections
  detection <- detect(model, atracacao_semanal[[x]]$total_tempo_espera)
  # filtering detected events
  print(detection |> dplyr::filter(event==TRUE))
  # evaluating the detections
  evaluation <- evaluate(model, detection$event, atracacao_semanal[[x]]$event)
  print(evaluation$confMatrix)
}

sae('Itajaí')

# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)


vanila <- function(x) {
  # establishing han_autoencoder method vanila
  model <- han_autoencoder(3,2)
  model <- fit(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
  # making detections
  detection <- detect(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
  # filtering detected events
  print(detection |> dplyr::filter(event==TRUE))
  # evaluating the detections
  evaluation <- evaluate(model, detection$event, atracacao_semanal[['São Francisco do Sul']]$event)
  print(evaluation$confMatrix)
}

vanila('Itajaí')


# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)



varae <- function(x) {
  print('Varae - ' + x)
  # establishing han_autoencoder method Varae
  model <- han_autoencoder(3, 2, varae_encode_decode, num_epochs = 1500)
  model <- fit(model, atracacao_semanal[[x]]$total_tempo_espera)
  # making detections
  detection <- detect(model, atracacao_semanal[[x]]$total_tempo_espera)
  # filtering detected events
  print(detection |> dplyr::filter(event==TRUE))
  # evaluating the detections
  evaluation <- evaluate(model, detection$event, atracacao_semanal[[x]]$event)
  print(evaluation$confMatrix)
}


lapply(atracacao_semanal, varae)

# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)

# data preprocessing dtree

atracacao_semanal[['São Francisco do Sul']]$event <- factor(atracacao_semanal[['São Francisco do Sul']]$event, labels=c("FALSE", "TRUE"))
slevels <- levels(atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)

train <- atracacao_semanal[['São Francisco do Sul']][1:2000,]
test <- atracacao_semanal[['São Francisco do Sul']][-(1:2000),]

norm <- minmax()
norm <- fit(norm, train)
train_n <- transform(norm, train)
summary(train_n)
# establishing decision tree method 
model <- hanc_ml(cla_dtree("event", slevels))
# fitting the model
model <- fit(model, train_n)
detection <- detect(model, train_n)
print(detection |> dplyr::filter(event==TRUE))
# evaluating the training
evaluation <- evaluate(model, detection$event, as.logical(train_n$event))
print(evaluation$confMatrix)
# ploting training results
grf <- har_plot(model, train_n$serie, detection, as.logical(train_n$event))
plot(grf)
# preparing for testing
test_n <- transform(norm, test)
# evaluating the detections during testing
detection <- detect(model, test_n)

print(detection |> dplyr::filter(event==TRUE))
evaluation <- evaluate(model, detection$event, as.logical(test_n$event))
print(evaluation$confMatrix)
# ploting the results during testing
grf <- har_plot(model, test_n$serie, detection, as.logical(test_n$event))
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)

summary(train_n)



# dwt

dwt_1 <- function(x) {
  print(x)
  atracacao_semanal[[x]]$event <- as.logical(atracacao_semanal[[x]]$event)
  
  model <- hanct_dtw(1)
  # fitting the model
  model <- fit(model, atracacao_semanal[[x]]$total_tempo_espera)
  # making detections of anomalies using kmeans
  detection <- detect(model, atracacao_semanal[[x]]$total_tempo_espera)
  # filtering detected events
  print(detection |> dplyr::filter(event==TRUE))
  # evaluating the detections
  evaluation <- evaluate(model, detection$event, atracacao_semanal[[x]]$event)
  print(evaluation$confMatrix)
}


dwt_1(nome_portos[8])


# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$tmp_atr_tempo_espera_atracaca, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)# ploting the results
res <-  attr(detection, "res")
plot(res)


dwt_3 <- function(x) {
  print(x)
  # establishing the method 
  model <- hanct_dtw(3)
  # fitting the model
  model <- fit(model, atracacao_semanal[[x]]$total_tempo_espera)
  # making detections of anomalies using kmeans
  detection <- detect(model, atracacao_semanal[[x]]$total_tempo_espera)
  # filtering detected events
  print(detection |> dplyr::filter(event==TRUE))
  # evaluating the detections
  evaluation <- evaluate(model, detection$event, atracacao_semanal[[x]]$event)
  print(evaluation$confMatrix)
}


dwt_3(nome_portos[7])

# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$tmp_atr_tempo_espera_atracaca, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)# ploting the results
res <-  attr(detection, "res")
plot(res)


kmeans_1 <- function(x) {
  print(x)
  # hanct kmeans anomaly
  model <- hanct_kmeans(1)
  model <- fit(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
  detection <- detect(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
  print(detection |> dplyr::filter(event==TRUE))
  # evaluating the detections
  evaluation <- evaluate(model, detection$event, atracacao_semanal[['São Francisco do Sul']]$event)
  print(evaluation$confMatrix)
}

kmeans_1(nome_portos[8])


# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$tmp_atr_tempo_espera_atracaca, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)# ploting the results
res <-  attr(detection, "res")
plot(res)


kmeans_3 <- function(x) {
  # hanct kmeans discord
  model <- hanct_kmeans(3)
  model <- fit(model, atracacao_semanal[[x]]$total_tempo_espera)
  detection <- detect(model, atracacao_semanal[[x]]$total_tempo_espera)
  print(detection |> dplyr::filter(event==TRUE))
  # evaluating the detections
  evaluation <- evaluate(model, detection$event, atracacao_semanal[[x]]$event)
  print(evaluation$confMatrix)
}
 


# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$tmp_atr_tempo_espera_atracaca, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)# ploting the results
res <-  attr(detection, "res")
plot(res)


# establishing arima method 
model <- hanr_arima()
# fitting the model
model <- fit(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
detection <- detect(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
print(detection |> dplyr::filter(event==TRUE))
# evaluating the detections
evaluation <- evaluate(model, detection$event, atracacao_semanal[['São Francisco do Sul']]$event)
print(evaluation$confMatrix)
# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$tmp_atr_tempo_espera_atracaca, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)# ploting the results
res <-  attr(detection, "res")
plot(res)


# establishing hanr_emd method 
model <- hanr_emd()
# fitting the model
model <- fit(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
detection <- detect(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
print(detection |> dplyr::filter(event==TRUE))
# evaluating the detections
evaluation <- evaluate(model, detection$event, atracacao_semanal[['São Francisco do Sul']]$event)
print(evaluation$confMatrix)
# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)# ploting the results
res <-  attr(detection, "res")
plot(res)


# establishing arima method ensemble
model <- model <- har_ensemble(hanr_fbiad(), hanr_arima(), hanr_emd())
# fitting the model
model <- fit(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# making detections
detection <- detect(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# filtering detected events
print(detection |> dplyr::filter(event==TRUE))
# evaluating the detections
evaluation <- evaluate(model, detection$event, atracacao_semanal[['São Francisco do Sul']]$event)
print(evaluation$confMatrix)
# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)

# establishing arima method enseble fuzzy
model <- model <- har_ensemble(hanr_fbiad(), hanr_arima(), hanr_emd())
model$time_tolerance <- 10
# fitting the model
model <- fit(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# making detections
detection <- detect(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# filtering detected events
print(detection |> dplyr::filter(event==TRUE))
# evaluating the detections
evaluation <- evaluate(model, detection$event, atracacao_semanal[['São Francisco do Sul']]$event)
print(evaluation$confMatrix)
# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)



fbiad <- function(x) {
  print(x)
  # establishing hanr_fbiad method 
  model <- hanr_fbiad()
  # fitting the model
  model <- fit(model, atracacao_semanal[[x]]$total_tempo_espera)
  # making detections
  detection <- detect(model, atracacao_semanal[[x]]$total_tempo_espera)
  # filtering detected events
  print(detection |> dplyr::filter(event==TRUE))
  # evaluating the detections
  evaluation <- evaluate(model, detection$event, atracacao_semanal[[x]]$event)
  print(evaluation$confMatrix)
  # ploting the results
  grf <- har_plot(model, atracacao_semanal[[x]]$total_tempo_espera, detection, atracacao_semanal[[x]]$event)
  plot(grf)
}


fbiad(nome_portos[1])


# ploting the results
res <-  attr(detection, "res")
plot(res)

# establishing hanr_fft method 
model <- hanr_fft()
# fitting the model
model <- fit(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# making detections
detection <- detect(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# filtering detected events
print(detection |> dplyr::filter(event==TRUE))
# evaluating the detections
evaluation <- evaluate(model, detection$event, atracacao_semanal[['São Francisco do Sul']]$event)
print(evaluation$confMatrix)
# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)


# establishing garch method 
model <- hanr_garch()
# fitting the model
model <- fit(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# making detections
detection <- detect(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# filtering detected events
print(detection |> dplyr::filter(event==TRUE))
# evaluating the detections
evaluation <- evaluate(model, detection$event, atracacao_semanal[['São Francisco do Sul']]$event)
print(evaluation$confMatrix)
# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)


# establishing conv1d method 
model <- hanr_ml(ts_conv1d(ts_norm_gminmax(), input_size=4, epochs=10000))
# fitting the model
model <- fit(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# making detections
detection <- detect(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# filtering detected events
print(detection |> dplyr::filter(event==TRUE))
# evaluating the detections
evaluation <- evaluate(model, detection$event, atracacao_semanal[['São Francisco do Sul']]$event)
print(evaluation$confMatrix)
# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)

# ml_elm
model <- hanr_ml(ts_elm(ts_norm_gminmax(), input_size=4, nhid=3, actfun="purelin"))
# fitting the model
model <- fit(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# making detections
detection <- detect(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# filtering detected events
print(detection |> dplyr::filter(event==TRUE))
# evaluating the detections
evaluation <- evaluate(model, detection$event, atracacao_semanal[['São Francisco do Sul']]$event)
print(evaluation$confMatrix)
# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)


# establishing lstm method 
model <- hanr_ml(ts_lstm(ts_norm_gminmax(), input_size=4, epochs=10000))
# fitting the model
model <- fit(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# making detections
detection <- detect(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# filtering detected events
print(detection |> dplyr::filter(event==TRUE))
# evaluating the detections
evaluation <- evaluate(model, detection$event, atracacao_semanal[['São Francisco do Sul']]$event)
print(evaluation$confMatrix)
# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)



# establishing mlp method 
model <- hanr_ml(ts_mlp(ts_norm_gminmax(), input_size=3, size=3, decay=0))
# fitting the model
model <- fit(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# making detections
detection <- detect(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# filtering detected events
print(detection |> dplyr::filter(event==TRUE))
# evaluating the detections
evaluation <- evaluate(model, detection$event, atracacao_semanal[['São Francisco do Sul']]$event)
print(evaluation$confMatrix)
# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)



# establishing random forest method 
model <- hanr_ml(ts_elm(ts_norm_gminmax(), input_size=4, nhid=3, actfun="purelin"))
# fitting the model
model <- fit(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# making detections
detection <- detect(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# filtering detected events
print(detection |> dplyr::filter(event==TRUE))
# evaluating the detections
evaluation <- evaluate(model, detection$event, atracacao_semanal[['São Francisco do Sul']]$event)
print(evaluation$confMatrix)
# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)

svm <- function(x) {
  # establishing SVM
  model <- hanr_ml(ts_svm(ts_norm_gminmax(), input_size=4,  kernel = "radial"))
  # fitting the model
  model <- fit(model, atracacao_semanal[[x]]$total_tempo_espera)
  # making detections
  detection <- detect(model, atracacao_semanal[[x]]$total_tempo_espera)
  # filtering detected events
  print(detection |> dplyr::filter(event==TRUE))
  # evaluating the detections
  evaluation <- evaluate(model, detection$event, atracacao_semanal[[x]]$event)
  print(evaluation$confMatrix)
}

svm(nome_portos[2])

# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)


# establishing hanr_emd method 
model <- hanr_red()
# fitting the model
model <- fit(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# making detections
detection <- detect(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# filtering detected events
print(detection |> dplyr::filter(event==TRUE))
# evaluating the detections
evaluation <- evaluate(model, detection$event, atracacao_semanal[['São Francisco do Sul']]$event)
print(evaluation$confMatrix)
# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)



# establishing hanr_remd method 
model <- hanr_remd()
# fitting the model
model <- fit(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# making detections
detection <- detect(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# filtering detected events
print(detection |> dplyr::filter(event==TRUE))
# evaluating the detections
evaluation <- evaluate(model, detection$event, atracacao_semanal[['São Francisco do Sul']]$event)
print(evaluation$confMatrix)
# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)


# establishing hanr_wavelet method 
model <- hanr_wavelet()
# fitting the model
model <- fit(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# making detections
detection <- detect(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera)
# filtering detected events
print(detection |> dplyr::filter(event==TRUE))
# evaluating the detections
evaluation <- evaluate(model, detection$event, atracacao_semanal[['São Francisco do Sul']]$event)
print(evaluation$confMatrix)
# ploting the results
grf <- har_plot(model, atracacao_semanal[['São Francisco do Sul']]$total_tempo_espera, detection, atracacao_semanal[['São Francisco do Sul']]$event)
plot(grf)
# ploting the results
res <-  attr(detection, "res")
plot(res)